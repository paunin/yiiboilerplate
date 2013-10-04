<?php

Yii::import('application.models._base.BaseUserSettings');

class UserSettings extends BaseUserSettings
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}