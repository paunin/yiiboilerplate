<?php

Yii::import('application.models._base.BaseToken');

class Token extends BaseToken
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}