<?php
class TagStringValidator extends CRegularExpressionValidator
{

    protected function validateAttribute($object, $attribute)
    {

        if(empty($this->pattern))
            $this->pattern = '/^[a-zA-Z_а-яА-Я0-9]{'.(Yii::app()->params['tag_length_min']).','.(Yii::app()->params['tag_length_max']).'}$/iU';
        if(empty($this->message))
            $this->message = Yii::t('app', 'Incorrect tag name');

        return parent::validateAttribute($object, $attribute);
    }
}