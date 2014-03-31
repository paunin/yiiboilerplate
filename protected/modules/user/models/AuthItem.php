<?php

Yii::import('application.modules.user.models._base.BaseAuthItem');

class AuthItem extends BaseAuthItem
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}