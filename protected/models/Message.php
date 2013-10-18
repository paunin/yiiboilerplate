<?php

Yii::import('application.models._base.BaseMessage');

/**
 * Class Message
 *
 * @method array toArray
 */
class Message extends BaseMessage
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(
                array('from_user_id, to_user_id', 'exist', 'className' => 'User', 'attributeName' => 'id'),
                array('text', 'filter', 'filter' => array('HtmlTextFilter', 'filterRtf'), 'on' => array('message_post')),
                array('id, to_user_id, from_user_id, subject, created_at, updated_at, read_at, from_deleted_at, to_deleted_at', 'unsafe', 'on' => 'message_post'),
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'SignableBehavior' => array(
                'class' => 'ext.behaviors.SignableBehavior.SignableBehavior',
                'createdByField' => 'from_user_id',
                'updatedByField' => null
            ),
            'ToArrayBehavior' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'subject', 'text', 'to_user_id', 'from_user_id',
                    'created_at', 'updated_at', 'read_at', 'to_deleted_at', 'from_deleted_at'
                )
            )
        );
    }

    /**
     * @return CDbCriteria
     */
    public static function getBaseCriteria()
    {
        $criteria = new CDbCriteria();
        $criteria->addCondition('
            (to_user_id = :first_person_id AND to_deleted_at IS NULL) OR
            (from_user_id = :first_person_id AND from_deleted_at IS NULL)
        ');
        return $criteria;
    }

    /**
     * @return CDbCriteria
     */
    public static function getDialogCriteria()
    {
        $criteria = Message::getBaseCriteria();
        $criteria->addCondition('to_user_id = :second_person_id OR from_user_id = :second_person_id');
        return $criteria;
    }
    /**
     * @return CDbCriteria
     */
    public static function getInboxCriteria()
    {
        $criteria = Message::getBaseCriteria();
        $criteria->addCondition('to_user_id = :first_person_id');
        return $criteria;
    }

    /**
     * @return CDbCriteria
     */
    public static function getOutboxCriteria()
    {
        $criteria = Message::getBaseCriteria();
        $criteria->addCondition('from_user_id = :first_person_id');
        return $criteria;
    }
    /**
     * @param $first_person_id
     * @param $second_person_id
     * @param $limit
     * @param $offset
     * @return Message[]
     */
    public function getDialog($first_person_id, $second_person_id, $limit, $offset)
    {
        if($limit > Yii::app()->params['message_limit_max'])
            $limit = Yii::app()->params['message_limit_max'];
        $criteria = Message::getDialogCriteria();
        $criteria->limit = $limit;
        $criteria->offset = $offset;
        $criteria->params = array(
            ':first_person_id' => $first_person_id,
            ':second_person_id' => $second_person_id
        );
        $criteria->order = "created_at DESC";
        return Message::model()->findAll($criteria);
    }

    /**
     * @param $first_person_id
     * @param $limit
     * @param $offset
     * @param bool $only_new
     * @return CActiveRecord[]
     */
    public static function getInbox($first_person_id, $limit, $offset, $only_new = false)
    {
        if($limit > Yii::app()->params['message_limit_max'])
            $limit = Yii::app()->params['message_limit_max'];
        $criteria = Message::getInboxCriteria();
        $criteria->limit = $limit;
        $criteria->offset = $offset;
        $criteria->params = array(
            ':first_person_id' => $first_person_id
        );
        $criteria->order = "created_at DESC";

        if($only_new){
            $criteria->addCondition('read_at IS NULL');
        }

        return Message::model()->findAll($criteria);
    }
    /**
     * @param $message_id
     * @param $first_person_id
     * @param $second_person_id
     * @return Message
     */
    public static function getOneWithUser($message_id, $first_person_id, $second_person_id)
    {
        $criteria = Message::getDialogCriteria();
        $criteria->params = array(
            ':first_person_id' => $first_person_id,
            ':second_person_id' => $second_person_id
        );
        $message = Message::model()->findByPk($message_id, $criteria);
        return $message;
    }

    /**
     * @param $message_id
     * @param $first_person_id
     * @return Message
     */
    public static function getOne($message_id, $first_person_id){
        $criteria = Message::getBaseCriteria();
        $criteria->params = array(
            ':first_person_id' => $first_person_id
        );
        $message = Message::model()->findByPk($message_id, $criteria);
        return $message;
    }


    /**
     * @param $first_person_id
     * @param $second_person_id
     * @param null $message_id
     * @return int
     */
    public static function readAll($first_person_id, $second_person_id, $message_id = null)
    {
        $criteria = Message::getDialogCriteria();
        $criteria->addCondition('read_at IS NULL');
        $criteria->addCondition('to_user_id = :first_person_id');
        $criteria->params = array(
            ':first_person_id' => $first_person_id,
            ':second_person_id' => $second_person_id
        );
        if($message_id){
            $criteria->addCondition('id <= :message_id');
            $criteria->params = array_merge($criteria->params,array(':message_id' => $message_id));
        }

        $message = Message::model()->updateAll(array('read_at' => date('Y-m-d H:i:s')), $criteria);
        return $message;
    }
}