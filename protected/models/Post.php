<?php

Yii::import('application.models._base.BasePost');
/**
 * Class Post
 *
 * @method array toArray
 */
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
                array('user_id', 'exist', 'className' => 'User', 'attributeName' => 'id'),

                array('point', 'required', 'on' => 'post_post'),
                array('point', 'application.validators.CoordinatePointValidator', 'on' => 'post_post', 'makeCoordinates' => true),
                array('point', 'application.validators.CoordinatePointValidator', 'reanimateCoordinates' => true, 'makeCoordinates' => true, 'on' => 'post_put'),

                array('created_at', 'application.validators.TimeLimitValidator', 'message' => Yii::t('app', 'Too late to edit this post'), 'timeLimit' => Yii::app()->params['post_allow_edit_time'], 'on' => 'post_put'),

                array('id, user_id, is_media, created_at, updated_at, cx, cy, cx_p_cy, cx_m_cy, post_id, point, deleted_at', 'unsafe', 'on' => array('post_post', 'post_put')),
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
                'createdByField' => 'user_id',
                'updatedByField' => null
            ),
            'ToArrayBehavior' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'subject', 'text', 'user_id', 'cx', 'cy', 'created_at', 'updated_at', 'deleted_at', 'post_id'
                )
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
        );
    }

    public function delete(){
        $this->deleted_at = date('Y-m-d H:i:s');
        return $this->save();
    }

}