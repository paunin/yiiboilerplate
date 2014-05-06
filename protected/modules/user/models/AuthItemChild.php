<?php

Yii::import('application.modules.user.models._base.BaseAuthItemChild');

class AuthItemChild extends BaseAuthItemChild
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}