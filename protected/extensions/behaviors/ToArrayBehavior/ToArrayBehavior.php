<?php
class ToArrayBehavior extends CActiveRecordBehavior
{

    /**
     * @var array of attributes of model for method toArray
     */
    public $fields = array();


    /**
     * @return array
     */
    public function toArray(){
        $result = array();
        /** @var CActiveRecord $record */
        $record = $this->getOwner();
        foreach($this->fields as $field){
          if($record->hasAttribute($field)){
              $result[$field] = $record->getAttribute($field);
          }
        }
        return $result;
    }
}

