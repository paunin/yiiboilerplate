<?php
class TagValidator extends CExistValidator
{

    public $className = "Tag";

    public $attributeName = "name";

    public $criteria = array();

    public $allowEmpty = false;

    public $createIfNotFound = false;

    public $makeId = false;
    public $idField = 'tag_id';
    public $objectField = 'tag';


    protected function validateAttribute($object, $attribute)
    {
        if(empty($this->message))
            $this->message = Yii::t('app', 'Tag not found');
        parent::validateAttribute($object, $attribute);

        if($object->hasErrors($attribute)) { //tag not found
            if($this->createIfNotFound) {
                $object->clearErrors($attribute);
                $tag = new Tag();
                $tag->name = $object->$attribute;
                if($tag->validate()) {
                    $tag->save();
                    if($this->makeId) {
                        $object->{$this->idField} = $tag->id;
                        $object->{$this->objectField} = $tag;
                    }
                } else {
                    foreach($tag->getErrors() as $field => $errors){
                        $this->addError($object, $attribute, 'tag_'.$field.":".implode(', ',$errors));
                    }

                }
            }
        } else { //found
            if($this->makeId) {
                $tag = Tag::model()->findByAttributes(array('name'=>$object->$attribute));
                $object->{$this->idField} = $tag->id;
                $object->{$this->objectField} = $tag;
            }
        }


    }
}