<?php

Yii::import('application.models._base.BasePost');

class Post extends BasePost
{
    public $point;
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(
                array('point', 'required', 'on' => 'post_post'),
                array('point', 'application.validators.CoordinatePointValidator', 'on' => 'post_post', 'makeCoordinates' => true),
                array('point', 'application.validators.CoordinatePointValidator', 'reanimateCoordinates' => true, 'makeCoordinates' => true, 'on' => 'post_put'),
                array('user_id', 'exist', 'className' => 'User', 'attributeName' => 'id'),
                array('id, user_id, is_media, created_at, updated_at, cx, cy, cx_p_cy, cx_m_cy, post_id', 'unsafe', 'on' => array('post_post','post_put')),
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'SignableBehavior' => array(
                'class' => 'ext.behaviors.SignableBehavior.SignableBehavior',
                'createdByField'=>'user_id',
                'updatedByField'=>null
            ),
            'ToArrayBehavior' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'subject', 'user_id', 'cx', 'cy', 'created_at', 'updated_at', 'post_id'
                )
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
        );
    }

}