<?php

Yii::import('application.models._base.BaseToken');

class Token extends BaseToken
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    public function behaviors()
    {
        return array(
            'CTimestampBehavior' => array(
                'class' => 'zii.behaviors.CTimestampBehavior',
                'createAttribute' => 'created_at',
                'updateAttribute' => 'updated_at',
                'timestampExpression' => "date('Y-m-d H:i:s')"
            ),
            'to_array' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'token', 'expire_at'
                )
            )
        );
    }
    public function rules(){
        return array_merge(
            array(
                array('created_at', 'default', 'setOnEmpty' => true, 'value' => date("Y-m-d H:i:s")),
            ),
            parent::rules()
        );
    }
}