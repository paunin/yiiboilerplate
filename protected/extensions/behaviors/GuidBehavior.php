<?php

class GuidBehavior extends CActiveRecordBehavior
{
    public $field = 'guid';

    public function findByGuid($guid)
    {
        /** @var CActiveRecord $record */
        $owner = $this->getOwner();
        if(!is_numeric($guid))
            return null;
        return $owner->findByAttributes(array($this->field => $guid));

    }

    /**
     * @param CEvent $event
     */
    public function afterValidate($event){
        /** @var CActiveRecord $owner */
        $owner = $this->getOwner();
        if($owner->hasErrors($this->field))
            $owner->clearErrors($this->field);
    }
} 