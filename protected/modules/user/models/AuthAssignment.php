<?php

Yii::import('application.modules.user.models._base.BaseAuthAssignment');

class AuthAssignment extends BaseAuthAssignment
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}