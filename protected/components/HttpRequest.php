<?php
class HttpRequest extends CHttpRequest
{
	
	private $fakeIP=null;

    /**
     * @return string
     */
    public function getUserHostAddress(){
        return $this->getUserHostAddressExt('HTTP_X_REAL_IP',true,array('REMOTE_ADDR'));
    }
    /**
     * @param null|string $ip_param_name - ключ элемента _SERVER, в котором нужно искать IP адрес
     *          если не задано ищем по индексу REMOTE_ADDR и считаем что проксирование отсутствует или прозрачное,
     *          если задано считаем что IP пробрасывается по заданному индексу,
     *              например по индексу HTTP_X_REAL_IP или любому другому
     * @param bool $allow_non_trusted - защита, при заданном $ip_param_name но
     *              отсутствующем или не валидном значении _SERVER[$ip_param_name]
     *          если задано будем искать в _SERVER по ключам из аргумента $non_trusted_param_names
     * @param array $non_trusted_param_names - массив ключей, по которым будем искать IP в массиве _SERVER
     * @throws Exception
     * @return string
     */
    public function getUserHostAddressExt(
        $ip_param_name = null,
        $allow_non_trusted = false,
        array $non_trusted_param_names = array('HTTP_X_REAL_IP','HTTP_CLIENT_IP','HTTP_X_FORWARDED_FOR','REMOTE_ADDR')
    ){
        if ($this->getFakeIP())
            return $this->getFakeIP();

    	if(empty($ip_param_name) || !is_string($ip_param_name)){
    	// если не задан или не корректен
            $ip = $_SERVER['REMOTE_ADDR'];
        }else{
        //иначе используем нужную переменную
            if(!empty($_SERVER[$ip_param_name]) && filter_var($_SERVER[$ip_param_name], FILTER_VALIDATE_IP)){
            // если переменная подошла как надо
                $ip = $_SERVER[$ip_param_name];
            }else if($allow_non_trusted){
            // мы решили пойти на крайний шаг и использовать сырые данные
                foreach($non_trusted_param_names as $ip_param_name_nt){
                    if($ip_param_name === $ip_param_name_nt)
                    // мы уже проверяли эту переменную
                        continue;
                    if(!empty($_SERVER[$ip_param_name_nt]) && filter_var($_SERVER[$ip_param_name_nt], FILTER_VALIDATE_IP)){
                    // если переменная подошла как надо
                        $ip = $_SERVER[$ip_param_name_nt];
                        break;
                    }
                }
            }
        }
        if(empty($ip))
        // так и не нашли подходящих ip, хотя по умолчанию в $_SERVER['REMOTE_ADDR'] что-то должно лежать
            throw new Exception("Can't detect IP");

        return $ip;
    }
    
    /**
     * @param $ip
     */
    public function setFakeIP($ip){
		$this->fakeIP = $ip;
    }    
    
    /**
     * @return string
     */
    public function getFakeIP(){
		return $this->fakeIP;
    }

    public $noCsrfValidationRoutes=array();

    protected function normalizeRequest()
    {
        parent::normalizeRequest();
        if($this->enableCsrfValidation)
        {
            $url=Yii::app()->getUrlManager()->parseUrl($this);
            foreach($this->noCsrfValidationRoutes as $route)
            {
                if(strpos($url,$route)===0)
                    Yii::app()->detachEventHandler('onBeginRequest',array($this,'validateCsrfToken'));
            }
        }
    }

    protected $_baseUrl;
    /**
     * @param bool $absolute
     * @param string $schema
     * @return string
     */
    public function getBaseUrl($absolute=false,$schema = '')
    {
        if($this->_baseUrl===null)
            $this->_baseUrl=rtrim(dirname($this->getScriptUrl()),'\\/');
        return $absolute ? $this->getHostInfo($schema) . $this->_baseUrl : $this->_baseUrl;
    }

     /**
     * Return if the request is sent via secure channel (https).
     * @return boolean if the request is sent via secure channel (https)
     */
    public function getIsSecureConnection()
    {
        if (parent::getIsSecureConnection())
            return true;

        return !empty($_SERVER['HTTP_HTTPS']) && strcasecmp($_SERVER['HTTP_HTTPS'],'off');
    }


}