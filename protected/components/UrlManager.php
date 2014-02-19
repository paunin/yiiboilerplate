<?php

class UrlManager extends CUrlManager
{
    //<<<-------------------------------------------------------
    public $languageParam = 'lang';
    public $noI18nParam = 'nolang';
    //public $countryParam = 'country';
    public $i18nRules = array();
    //>>>-------------------------------------------------------

    private $_rules = array();

    /**
     * Processes the URL rules.
     */
    protected function processRules()
    {
        if(empty($this->rules) || $this->getUrlFormat() === self::GET_FORMAT)
            return;
        if($this->cacheID !== false && ($cache = Yii::app()->getComponent($this->cacheID)) !== null) {
            $hash = md5(serialize($this->rules));
            if(($data = $cache->get(self::CACHE_KEY)) !== false && isset($data[1]) && $data[1] === $hash) {
                $this->_rules = $data[0];
                return;
            }
        }
        //<<<-------------------------------------------------------
        //$lc = "<{$this->countryParam}:[a-z]{2}>_<{$this->languageParam}:[a-z]{2}>/";
        $l = "<{$this->languageParam}:[a-z]{2}>/";
        foreach ($this->i18nRules as $pattern => $route) {
            if(is_array($route)) {
                if(isset($route['pattern'])){
                    $i18n_route = $route;

                    //$i18n_route['pattern'] = $lc . $route['pattern'];
                    //$this->_rules[] = $this->createUrlRule($i18n_route, $pattern);

                    $i18n_route['pattern'] = $l . $route['pattern'];
                    $this->_rules[] = $this->createUrlRule($i18n_route, $pattern);

                }
            } else {
                //$this->_rules[] = $this->createUrlRule($route, $lc . $pattern);
                $this->_rules[] = $this->createUrlRule($route, $l . $pattern);

            }
            $this->_rules[] = $this->createUrlRule($route, $pattern);
        }
        //>>>-------------------------------------------------------




        foreach ($this->rules as $pattern => $route)
            $this->_rules[] = $this->createUrlRule($route, $pattern);
        if(isset($cache))
            $cache->set(self::CACHE_KEY, array($this->_rules, $hash));
    }

    /**
     * @see CUrlManager::createUrl
     *
     * @param string $route
     * @param array $params
     * @param string $ampersand
     * @param bool $nolang
     * @return string
     */
    public function createUrl($route,$params=array(),$ampersand='&', $nolang = false)
    {
        if(!$nolang && empty($params[$this->noI18nParam]))
            if(empty($params[$this->languageParam]))
                $params[$this->languageParam] = Yii::app()->language;

        if(!empty($params[$this->noI18nParam]))
            unset($params[$this->noI18nParam]);

        //-----------------------------------------------
        unset($params[$this->routeVar]);
        foreach($params as $i=>$param)
            if($param===null)
                $params[$i]='';

        if(isset($params['#']))
        {
            $anchor='#'.$params['#'];
            unset($params['#']);
        }
        else
            $anchor='';
        $route=trim($route,'/');
        foreach($this->_rules as $i=>$rule)
        {
            if(is_array($rule))
                $this->_rules[$i]=$rule=Yii::createComponent($rule);
            if(($url=$rule->createUrl($this,$route,$params,$ampersand))!==false)
            {
                if($rule->hasHostInfo)
                    return $url==='' ? '/'.$anchor : $url.$anchor;
                else
                    return $this->getBaseUrl().'/'.$url.$anchor;
            }
        }
        return $this->createUrlDefault($route,$params,$ampersand).$anchor;
    }



    //зависимости на $this->_rules





    /**
     * Adds new URL rules.
     * In order to make the new rules effective, this method must be called BEFORE
     * {@link CWebApplication::processRequest}.
     * @param array $rules new URL rules (pattern=>route).
     * @param boolean $append whether the new URL rules should be appended to the existing ones. If false,
     * they will be inserted at the beginning.
     * @since 1.1.4
     */
    public function addRules($rules,$append=true)
    {
        if ($append)
        {
            foreach($rules as $pattern=>$route)
                $this->_rules[]=$this->createUrlRule($route,$pattern);
        }
        else
        {
            $rules=array_reverse($rules);
            foreach($rules as $pattern=>$route)
                array_unshift($this->_rules, $this->createUrlRule($route,$pattern));
        }
    }



    /**
     * Parses the user request.
     * @param CHttpRequest $request the request application component
     * @return string the route (controllerID/actionID) and perhaps GET parameters in path format.
     */
    public function parseUrl($request)
    {
        if($this->getUrlFormat()===self::PATH_FORMAT)
        {
            $rawPathInfo=$request->getPathInfo();
            $pathInfo=$this->removeUrlSuffix($rawPathInfo,$this->urlSuffix);
            foreach($this->_rules as $i=>$rule)
            {
                if(is_array($rule))
                    $this->_rules[$i]=$rule=Yii::createComponent($rule);
                if(($r=$rule->parseUrl($this,$request,$pathInfo,$rawPathInfo))!==false)
                    return isset($_GET[$this->routeVar]) ? $_GET[$this->routeVar] : $r;
            }
            if($this->useStrictParsing)
                throw new CHttpException(404,Yii::t('yii','Unable to resolve the request "{route}".',
                    array('{route}'=>$pathInfo)));
            else
                return $pathInfo;
        }
        elseif(isset($_GET[$this->routeVar]))
            return $_GET[$this->routeVar];
        elseif(isset($_POST[$this->routeVar]))
            return $_POST[$this->routeVar];
        else
            return '';
    }


}