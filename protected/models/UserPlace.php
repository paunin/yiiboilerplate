<?php

Yii::import('application.models._base.BaseUserPlace');
/**
 * @method array toArray
 */
class UserPlace extends BaseUserPlace
{
    public $cxy;

    public function rules()
    {

        return array_merge(
            array(
                array('cxy', 'required', 'on' => 'place_post'),
                array('cxy', 'application.validators.CoordinatePointValidator', 'on' => 'place_post','makeCoordinates' => true),
                array('cxy', 'application.validators.CoordinatePointValidator', 'reanimateCoordinates' => true,'makeCoordinates' => true, 'on' => 'place_put'),
                array('cxy', 'checkOccupied'),
            ),
            parent::rules(),
            array(
                array('cx,cy','unsafe'),
                array('user_id', 'exist', 'attributeName' => 'id', 'className' => 'User'),
                array('radius', 'application.validators.RadiusValidator'),
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'to_array' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'name', 'cx', 'cy', 'created_at', 'updated_at', 'radius', 'is_spirit'
                )
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
        );
    }

    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * @param string $attribute
     * @param array $params
     */
    public function checkOccupied($attribute, $params)
    {
        //check if place in use by over User
        if (
            !$this->is_spirit &&
            UserPlace::countByCoordinates($this->getAttribute('cx'), $this->getAttribute('cy'), false, $this->user_id)
        )
            $this->addError('cxy', Yii::t('app', 'Place is already occupied'));

    }

    /**
     * @return bool|void
     */
    public function beforeValidate()
    {
        $this->permissions = $this->is_spirit ? 2 : 6; //r:rw
        /** @var User $user */
        $user = User::model()->findByPk($this->getAttribute('user_id'));
        if ($this->getIsNewRecord() && count($user->userPlaces) >= Yii::app()->params['places_count_max'])
            $this->addError('_overall', Yii::t('app', 'You can\'t have more than {places_count_max} places', array('{places_count_max}' => Yii::app()->params['places_count_max'])));


        if ($this->hasErrors())
            return false;

        return parent::beforeValidate();
    }

    /**
     * @param int $cx
     * @param int $cy
     * @param bool $with_spirits
     * @param int|null $exclude_user_id
     * @return string
     */
    public static function countByCoordinates($cx, $cy, $with_spirits = true, $exclude_user_id = null)
    {
        $criteria = UserPlace::getCriteriaForCoordinates($cx, $cy, $with_spirits);
        if ($exclude_user_id) {
            $criteria->addCondition('user_id != :user_id');
            $criteria->params[':user_id'] = $exclude_user_id;
        }
        return UserPlace::model()->count($criteria);
    }

    /**
     * @param $cx
     * @param $cy
     * @param bool $with_spirits
     * @return CDbCriteria
     */
    public static function getCriteriaForCoordinates($cx, $cy, $with_spirits = true)
    {
        $criteria = new CDbCriteria();
        $criteria->addCondition('cx = :cx');
        $criteria->addCondition('cy = :cy');

        $params = array(
            ':cx' => $cx,
            ':cy' => $cy,
        );

        if (!$with_spirits) {
            $criteria->addCondition('is_spirit = false');
        }
        $criteria->params = $params;
        return $criteria;
    }

    /**
     * @return bool
     */
    public function beforeSave()
    {
        if ($this->getIsNewRecord()) {
            $criteria = self::getCriteriaForCoordinates($this->cx, $this->cy);
            $criteria->addCondition('user_id = :user_id');
            $criteria->params[':user_id'] = $this->user_id;

            UserPlace::model()->deleteAll($criteria);
        }
        if ($this->is_spirit == false) {
            $criteria = new CDbCriteria();
            $criteria->addCondition('is_spirit = false');
            $criteria->addCondition('user_id = :user_id');
            $criteria->params[':user_id'] = $this->user_id;

            UserPlace::model()->updateAll(array('is_spirit' => true), $criteria);
        }

        return parent::beforeSave();
    }

    /**
     * @param $id
     * @param null $user_id
     * @return CActiveRecord
     * @throws CException
     */
    public static function findByPkForUser($id,$user_id = null){
        if(!$user_id && User::current())
            $user_id = User::current()->id;
        else
            throw new CException('user_id undefined');

        return UserPlace::model()->findByPk(
            $id,
            'user_id = :user_id',
            array(':user_id' => $user_id)
        );
    }

}