<?php

Yii::import('application.models._base.BaseUserFeedExternal');

class UserFeedExternal extends BaseUserFeedExternal
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}