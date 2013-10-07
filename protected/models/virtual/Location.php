<?php

class Location extends CModel
{
    /** @var  int scale for map */
    public $scale;

    public function attributeNames()
    {
        return array(
            'scale'
        );
    }

    public function rules(){
        return array(
            array('scale, vector', 'required'),
            array('scale', 'application.validators.MapScaleValidator'),
        );
    }
}