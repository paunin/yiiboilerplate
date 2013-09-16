<?php

Yii::import('application.models._base.BaseSmtp');

class Smtp extends BaseSmtp
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}