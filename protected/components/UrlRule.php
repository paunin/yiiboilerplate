<?php
class UrlRule extends CUrlRule {

    /**
     * Добавлена обработка добавки языков
     * @see CUrlRule::createUrl
     */
    public function createUrl($manager,$route,$params,$ampersand)
    {
        foreach($this->params as $key=>$value)
            if(!isset($params[$key])) {
                //<<<------------
                if ($key == $manager->languageParam) {
                    $params[$key] = Yii::app()->language;
                } /* elseif ($key == $manager->countryParam) {
                    $params[$key] = Yii::app()->params['system_country'];
                }*/
            }
        return parent::createUrl($manager,$route,$params,$ampersand);
    }
} 