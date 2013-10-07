<?php

class CoordinateVectorValidator extends CoordinatePointValidator
{
    /** @var string field for X0 coordinate */
    public $cx0_field = 'cx0';
    /** @var string field for Y0 coordinate */
    public $cy0_field = 'cy0';

    /** @var string field for X1 coordinate */
    public $cx1_field = 'cx1';
    /** @var string field for Y1 coordinate */
    public $cy1_field = 'cy1';

    /** @var string field for A point coordinate */
    public $pa_field = 'pa';
    /** @var string field for B point coordinate */
    public $pb_field = 'pb';

    /** @var bool '-5:5::-10:-10' will transform to '-10:5::-5:-10' */
    public $optimize = false;


    /**
     * @param CActiveRecord $object
     * @param string $attribute
     */
    protected function validateAttribute($object, $attribute)
    {
        $value = $object->$attribute;

        if(!$this->validateVector($value, true)) {
            $this->addError($object, $attribute, !empty($this->message) ? $this->message : Yii::t('app', 'Wrong vector coordinates'));
        } else {
            if($this->optimize) {
                $pa = $this->genPoint($value, 'a');
                $pb = $this->genPoint($value, 'b');
                $cx0 = $this->genCoordinate($pa, 'x');
                $cx1 = $this->genCoordinate($pb, 'x');
                $cy0 = $this->genCoordinate($pa, 'y');
                $cy1 = $this->genCoordinate($pb, 'y');
                if($cx0 > $cx1){
                    $t = $cx0;  $cx0 = $cx1; $cx1 = $t;
                    unset($t);
                }
                if($cy1 > $cy0){
                    $t = $cy1;  $cy1 = $cy0; $cy0 = $t;
                    unset($t);
                }
                $object->$attribute = "$cx0:$cy0::$cx1:$cy1";
                $value = $object->$attribute;
            }

            if($this->makeCoordinates) {
                $object->{$this->pa_field} = $this->genPoint($value, 'a');
                $object->{$this->pb_field} = $this->genPoint($value, 'b');
                $object->{$this->cx0_field} = $this->genCoordinate($object->{$this->pa_field}, 'x');
                $object->{$this->cx1_field} = $this->genCoordinate($object->{$this->pb_field}, 'x');
                $object->{$this->cy0_field} = $this->genCoordinate($object->{$this->pa_field}, 'y');
                $object->{$this->cy1_field} = $this->genCoordinate($object->{$this->pb_field}, 'y');
            }
        }

    }

    /**
     * @param $value
     * @param bool $not_line
     * @return bool
     */
    protected function validateVector($value, $not_line = false)
    {
        $pa = $this->genPoint($value, 'a');
        $pb = $this->genPoint($value, 'b');

        if(
            // real points
            $this->validatePoint($pa) &&
            $this->validatePoint($pb) &&
            //check if line
            (!$not_line ||
                (
                    $this->genCoordinate($pa, 'x') != $this->genCoordinate($pb, 'x') &&
                    $this->genCoordinate($pa, 'y') != $this->genCoordinate($pb, 'y')
                )
            )
        ) {

            return true;
        } else {
            return false;
        }


    }

    /**
     * @param $value
     * @param $point
     * @return null
     */
    protected function genPoint($value, $point)
    {
        $result = LocationVector::toPoints($value);
        return $result[$point];
    }

} 