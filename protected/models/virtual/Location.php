<?php

class Location extends CModel
{
    /** @var  int scale for map */
    public $scale = 1;

    public function attributeNames()
    {
        return array(
            'scale'
        );
    }

    public function rules(){
        return array(
            array('scale', 'application.validators.MapScaleValidator', 'integerOnly'=>true),
        );
    }
}