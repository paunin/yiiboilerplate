<?php

Yii::import('application.models._base.BaseFavorite');

/**
 * Class Favorite
 *
 * @property User $favoriteUser
 */
class Favorite extends BaseFavorite
{
    const TYPE_USER = 'user';
    const TYPE_POST = 'post';
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            )
        );
    }

    public function rules(){
        return array_merge(
            parent::rules(),
            array(
                array('user_id+favorite_id+type', 'application.validators.uniqueMultiColumnValidator','message'=>Yii::t('app','Already in favorites'))
            )
        );
    }

    public function relations(){
        return array_merge(
            parent::relations(),
            array(
                'favoriteUser' => array(self::BELONGS_TO, 'User','favorite_id'),
                'favoritePost' => array(self::BELONGS_TO, 'Post','favorite_id'),
            )
        );
    }
}