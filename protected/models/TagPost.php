<?php

Yii::import('application.models._base.BaseTagPost');

class TagPost extends BaseTagPost
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
    public function rules(){
        return array_merge(
            parent::rules(),
            array(
                array('tag_id', 'exist', 'attributeName' => 'id', 'className' => 'Tag'),
                array('post_id', 'exist', 'attributeName' => 'id', 'className' => 'Post'),
                array('post_id+tag_id', 'application.validators.uniqueMultiColumnValidator','message'=>Yii::t('app','Already with tag'))
            )
        );
    }
}