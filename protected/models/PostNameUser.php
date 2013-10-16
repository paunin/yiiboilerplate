<?php

Yii::import('application.models._base.BasePostNameUser');

class PostNameUser extends BasePostNameUser
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
    public function rules(){
        return array_merge(
            parent::rules(),
            array(
                array('user_id', 'exist', 'attributeName' => 'id', 'className' => 'User'),
                array('post_id', 'exist', 'attributeName' => 'id', 'className' => 'Post'),
                array('post_id+user_id', 'application.validators.uniqueMultiColumnValidator','message'=>Yii::t('app','Already with username'))
            )
        );
    }
}