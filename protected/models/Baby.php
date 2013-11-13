<?php

Yii::import('application.models._base.BaseBaby');

class Baby extends BaseBaby
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
                'updateAttribute' => null
            ),
            'SignableBehavior' => array(
                'class' => 'ext.behaviors.SignableBehavior.SignableBehavior',
                'updatedByField' => null
            ),
        );
    }
}