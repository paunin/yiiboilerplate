<?php

class Cook
{
    /**
     * @static
     * @param string $name
     * @return string
     */
    public static function get($name)
    {
        $cookie = Yii::app()->request->cookies[$name];
        $value = $cookie->value;
        return $value;
    }
    
    /**
     * @static
     * @param string $name
     * @param string $value
     * @return void
     */
    public static function set($name,$value)
    {
        $cookie=new CHttpCookie($name,$value);
        Yii::app()->request->cookies[$name]=$cookie;
    }
}
