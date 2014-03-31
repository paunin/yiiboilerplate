<?php

Yii::import('application.models._base.BaseApplication');

class Application extends BaseApplication
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}