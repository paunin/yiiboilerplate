<?php
class UrlRule extends CUrlRule {

    /**
     * Creates a URL based on this rule.
     * @param UrlManager $manager the manager
     * @param string $route the route
     * @param array $params list of parameters
     * @param string $ampersand the token separating name-value pairs in the URL.
     * @return mixed the constructed URL or false on error
     */
    public function createUrl($manager,$route,$params,$ampersand)
    {
        if($this->parsingOnly)
            return false;

        if($manager->caseSensitive && $this->caseSensitive===null || $this->caseSensitive)
            $case='';
        else
            $case='i';

        $tr=array();
        if($route!==$this->route)
        {
            if($this->routePattern!==null && preg_match($this->routePattern.$case,$route,$matches))
            {
                foreach($this->references as $key=>$name)
                    $tr[$name]=$matches[$key];
            }
            else
                return false;
        }

        foreach($this->defaultParams as $key=>$value)
        {
            if(isset($params[$key]))
            {
                if($params[$key]==$value)
                    unset($params[$key]);
                else
                    return false;
            }
        }

        foreach($this->params as $key=>$value)
            if(!isset($params[$key])) {
                //<<<------------
                if ($key == $manager->languageParam) {
                    $params[$manager->languageParam] = Yii::app()->language;
                } else /*if ($key == $manager->countryParam) {
                    $params[$manager->countryParam] = Yii::app()->params['system_country'];
                } else*/ {
                //<<<------------
                    return false;
                }
            }

        if($manager->matchValue && $this->matchValue===null || $this->matchValue)
        {
            foreach($this->params as $key=>$value)
            {
                if(!preg_match('/\A'.$value.'\z/u'.$case,$params[$key]))
                    return false;
            }
        }

        foreach($this->params as $key=>$value)
        {
            $tr["<$key>"]=urlencode($params[$key]);
            unset($params[$key]);
        }

        $suffix=$this->urlSuffix===null ? $manager->urlSuffix : $this->urlSuffix;

        $url=strtr($this->template,$tr);

        if($this->hasHostInfo)
        {
            $hostInfo=Yii::app()->getRequest()->getHostInfo();
            if(stripos($url,$hostInfo)===0)
                $url=substr($url,strlen($hostInfo));
        }

        if(empty($params))
            return $url!=='' ? $url.$suffix : $url;

        if($this->append)
            $url.='/'.$manager->createPathInfo($params,'/','/').$suffix;
        else
        {
            if($url!=='')
                $url.=$suffix;
            $url.='?'.$manager->createPathInfo($params,'=',$ampersand);
        }

        return $url;
    }
} 