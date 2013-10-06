<?php

class CoordinateValidator extends CValidator
{
    protected function validateAttribute($object, $attribute)
    {
        $value = $object->getAttribute($attribute);
        if (!$this->validateCoordinate($value)) {
            $this->addError($object, $attribute, !empty($this->message)?$this->message:Yii::t('app', 'Wrong coordinate'));
        }
    }

    protected function validateCoordinate($value)
    {
       return (is_numeric($value) && $value > Yii::app()->params['coordinate_min'] && $value < Yii::app()->params['coordinate_max'])?true:false;
    }
} 