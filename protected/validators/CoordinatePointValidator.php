<?php

class CoordinatePointValidator extends CoordinateValidator
{
    /**
     * @var string field for X coordinate
     */
    public $cx_field = 'cx';
    /**
     * @var string field for Y coordinate
     */
    public $cy_field = 'cy';

    /**
     * @var bool make two coordinates in $cx_field and $cy_field
     */
    public $makeCoordinates = false;
    /**
     * @var bool reanimate coordinates from $cx_field and $cy_field
     */
    public $reanimateCoordinates = false;

    /**
     * @param CActiveRecord $object
     * @param string $attribute
     */
    protected function validateAttribute($object, $attribute)
    {

        $value = $object->$attribute;

        if (empty($value) && $this->reanimateCoordinates) {
            $object->$attribute = $object->{$this->cx_field} . ':' . $object->{$this->cy_field};
        }

        $value = $object->$attribute;

        if (!$this->validatePoint($value, $object)) {
            $this->addError($object, $attribute, !empty($this->message) ? $this->message : Yii::t('app', 'Wrong point coordinates'));
        } else if ($this->makeCoordinates) {
            $object->{$this->cx_field} = $this->genCoordinate($value, 'x');
            $object->{$this->cy_field} = $this->genCoordinate($value, 'y');
        }
    }

    /**
     * @param $value
     * @param $asix
     * @return null
     */
    protected function genCoordinate($value, $asix)
    {
        $result = LocationPoint::toCoordinates($value);
        return $result[$asix];
    }

    /**
     * @param $value
     * @return bool
     */
    protected function validatePoint($value)
    {
        if ($this->validateCoordinate($this->genCoordinate($value, 'x')) && $this->validateCoordinate($this->genCoordinate($value, 'y'))) {
            return true;
        } else {
            return false;
        }
    }
} 