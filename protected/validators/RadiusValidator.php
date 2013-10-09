<?php
class RadiusValidator extends CNumberValidator
{
    /**
     * @var bool
     */
    public $createOnEmpty = false;

    /**
     * @param CActiveRecord $object
     * @param string $attribute
     */
    protected function validateAttribute($object, $attribute)
    {

        if(empty($object->$attribute) && $this->createOnEmpty){
            $user = User::current();
            if($user && $user->getUserSettings('radius')){
                $object->$attribute = $user->getUserSettings('radius');
            }else{
                $object->$attribute = Yii::app()->params['radius_default'];
            }
        }


        $this->integerOnly = true;
        if(empty($this->max))
            $this->max = Yii::app()->params['radius_max'];
        if(empty($this->min))
            $this->min = Yii::app()->params['radius_min'];
        if(empty($this->tooBig))
            $this->tooBig = Yii::t('app', 'Radius should be less than or equal {radius_max}', array('{radius_max}' => Yii::app()->params['radius_max']));
        if(empty($this->tooSmall))
            $this->tooSmall = Yii::t('app', 'Radius should be more than or equal {radius_min}', array('{radius_min}' => Yii::app()->params['radius_min']));
        if(empty($this->message))
            $this->message = Yii::t('app','Incorrect radius');

        return parent::validateAttribute($object, $attribute);

    }

}