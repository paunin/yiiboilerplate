<?php

Yii::import('application.models._base.BaseContent');

class Content extends BaseContent
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}