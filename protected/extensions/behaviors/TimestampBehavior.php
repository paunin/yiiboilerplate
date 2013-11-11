<?php
Yii::import('zii.behaviors.CTimestampBehavior');

class TimestampBehavior extends CTimestampBehavior {
    public $createAttribute = 'created_at';
    public $updateAttribute = 'updated_at';
    public $timestampExpression = "date('Y-m-d H:i:s')";
    public $setOnEmpty=true;

    public function beforeSave($event){

    }
    public function beforeValidate($event){
        return parent::beforeSave($event);
    }


} 