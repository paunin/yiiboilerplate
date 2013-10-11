<?php
/**
 * To use it u need to realize `public function recountWeights($delta,$self = true)` in model
 *
 * Class WeightBehavior
 */
class WeightBehavior extends CActiveRecordBehavior {
    public $weightField = 'weight';
    public $self = false;

    public function beforeSave($event){
        /** @var TagPlace $record */
        $record = $this->getOwner();
        if($record->getIsNewRecord()){
            $weight = $record->recountWeights(1,$this->self);
            $record->{$this->weightField} = $weight;
        }
        return parent::beforeSave($event);
    }
    public function afterDelete($event){
        /** @var TagPlace $record */
        $record = $this->getOwner();
        $record->recountWeights(-1,$this->self);
        return parent::afterDelete($event);
    }

} 