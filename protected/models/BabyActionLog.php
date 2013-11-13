<?php

Yii::import('application.models._base.BaseBabyActionLog');

class BabyActionLog extends BaseBabyActionLog
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function attributeLabels()
    {
        return
            array_merge(
                parent::attributeLabels(),
                array(
                    'baby_action_category_id'=>Yii::t('app','Action')
                )
            );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
                'updateAttribute' => null
            )
        );
    }
}