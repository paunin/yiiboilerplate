<?php
class TagAroundValidator extends CValidator
{

    protected function validateAttribute($object, $attribute)
    {
        if(empty($this->message))
            $this->message = Yii::t('app', 'You already have this tag somewhere here');

        $this->addError($object,$attribute,$this->message);
    }
}