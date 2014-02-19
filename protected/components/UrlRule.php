<?php
/**
 * User: paunin
 * Date: 18.02.14
 * Time: 17:30
 */

class UrlRule extends CUrlRule {


    public function createUrl($manager,$route,$params,$ampersand){
        return parent::createUrl($manager,$route,$params,$ampersand);
    }
} 