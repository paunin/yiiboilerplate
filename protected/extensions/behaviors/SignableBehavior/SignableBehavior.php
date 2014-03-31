<?php
class SignableBehavior extends CActiveRecordBehavior
{
    public $createdByField = 'created_by';
    public $updatedByField = 'updated_by';
    public $setUpdateOnCreate = false;

    /**
     * @param CModelEvent $event
     */
    public function beforeValidate($event){
        /** @var CActiveRecord $record */
        $record = $this->getOwner();
        if($record->getIsNewRecord() && $this->createdByField && empty($record->{$this->createdByField})){
            $record->{$this->createdByField} = Yii::app()->user->getId();
        }

        if(($this->updatedByField ) && (!$record->getIsNewRecord() || $this->setUpdateOnCreate)){
            $record->{$this->updatedByField} = Yii::app()->user->getId();
        }

        return parent::beforeValidate($event);
    }
}

