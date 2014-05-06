<?php
class TagStringValidator extends CRegularExpressionValidator
{
    public $tag_pattern = '[a-zA-Z_а-яА-Я0-9]{2,25}?';
    protected function validateAttribute($object, $attribute)
    {

        if(empty($this->pattern))
            $this->pattern = '/^'.$this->tag_pattern.'$/iU';
        if(empty($this->message))
            $this->message = Yii::t('app', 'Incorrect tag name');

        return parent::validateAttribute($object, $attribute);
    }
}