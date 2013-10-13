<?php
class TimeLimitValidator extends CValidator
{
    public $timeField = 'created_at';
    /** @var null|int time limit, 0 - no limits  */
    public $timeLimit = null;

    /**
     * @param CModel $object
     * @param string $attribute
     */
    protected function validateAttribute($object, $attribute)
    {
        if($this->timeLimit){
            $value = $object->$attribute;

        }
    }

}