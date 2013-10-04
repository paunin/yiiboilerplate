<?php

Yii::import('application.models._base.BaseUserSettings');

class UserSettings extends BaseUserSettings
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    public function rules() {
        return array_merge(
            parent::rules(),
            array(
                array('radius', 'numerical', 'integerOnly'=>true,
                    'min'=>Yii::app()->params['radius_min'],
                    'tooSmall' => Yii::t('app','Radius should be more equal than '.Yii::app()->params['radius_min'] ),
                    'max'=>Yii::app()->params['radius_max'],
                    'tooBig'=> Yii::t('app','Radius should be less or equal than '.Yii::app()->params['radius_max'] )
                )
            )
        );
    }
}