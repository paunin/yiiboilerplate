<?php

class MapScaleValidator extends CNumberValidator
{

    /**
     * @param CActiveRecord $object
     * @param string $attribute
     */
    protected function validateAttribute($object, $attribute)
    {
        $this->integerOnly = true;
        if(empty($this->max))
            $this->max = Yii::app()->params['map_scale_max'];
        if(empty($this->min))
            $this->min = Yii::app()->params['map_scale_min'];
        if(empty($this->tooBig))
            $this->tooBig = Yii::t('app','Incorrect scale');
        if(empty($this->tooSmall))
            $this->tooSmall = Yii::t('app','Incorrect scale');
        if(empty($this->message))
            $this->message = Yii::t('app','Incorrect scale');

        return parent::validateAttribute($object, $attribute);

    }

} 