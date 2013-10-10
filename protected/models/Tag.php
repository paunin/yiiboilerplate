<?php

Yii::import('application.models._base.BaseTag');
/**
 * Class Tag
 *
 * @method string errorsAgg
 * @method array toArray
 */
class Tag extends BaseTag
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(
                array('name', 'application.validators.TagStringValidator'),
                array('name', 'unique','className'=>"Tag", 'attributeName'=>'name')
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'ToArrayBehavior' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'name'
                )
            ),
            'ErrorsAggBehavior' => array(
                'class' => 'ext.behaviors.ErrorsAggBehavior'
            )
        );
    }
}