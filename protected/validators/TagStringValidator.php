<?php
class TagStringValidator extends CRegularExpressionValidator
{

    protected function validateAttribute($object, $attribute)
    {

        if(empty($this->pattern))
            $this->pattern = '/^'.Yii::app()->params['tag_pattern'].'$/iU';
        if(empty($this->message))
            $this->message = Yii::t('app', 'Incorrect tag name');

        return parent::validateAttribute($object, $attribute);
    }
}