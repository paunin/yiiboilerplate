<?php

Yii::import('application.models._base.BaseTagPlace');

class TagPlace extends BaseTagPlace
{
    public $point;
    public $tag_name;

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    public function rules()
    {
        return array_merge(
            array(
                array('point', 'required', 'on' => 'tag_place_post'),
                array('point', 'application.validators.CoordinatePointValidator', 'on' => 'tag_place_post','makeCoordinates' => true),
                array('tag_name', 'application.validators.TagValidator', 'on' => 'tag_place_post','createIfNotFound' => true,'makeId'=>true),
                array('tag_name', 'application.validators.TagAroundValidator', 'on' => 'tag_place_post'),
            ),
            parent::rules(),
            array(
                array('user_id', 'exist', 'attributeName' => 'id', 'className' => 'User'),
                array('tag_id', 'exist', 'attributeName' => 'id', 'className' => 'Tag'),
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
        );
    }
}