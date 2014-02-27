<?php

class UrlManager extends CUrlManager
{
    //<<<-------------------------------------------------------
    public $languageParam = 'lang';
    //public $countryParam = 'country';
    public $i18nRules = array();
    public $urlRuleClass='UrlRule';
    //>>>-------------------------------------------------------

    public function init(){

        //<<<-------------------------------------------------------
        $rules = array();
        $rules_l = array();
        $rules_lc = array();
        //$lc = "<{$this->countryParam}:[a-z]{2}>_<{$this->languageParam}:[a-z]{2}>/";
        $l = "<{$this->languageParam}:[a-z]{2}>/";

        foreach ($this->i18nRules as $pattern => $route) {
            if(is_array($route)) {
                if(isset($route['pattern'])){
                    $i18n_route = $route;

                    //$i18n_route['pattern'] = $lc . $route['pattern'];
                    //$rules_lc[$pattern] = $i18n_route;

                    $i18n_route['pattern'] = $l . $route['pattern'];
                    $rules_l[$pattern] = $i18n_route;

                }
            } else {
                //$rules[ $lс . $pattern] = $route;
                $rules[ $l . $pattern] = $route;

            }
            $rules[$pattern] = $route;
        }
        //>>>-------------------------------------------------------
        $this->addRules($rules_lc);
        $this->addRules($rules_l);
        $this->addRules($rules);
        return parent::init();
    }
}