<?php

class ErrorsAggBehavior extends CBehavior
{

    public function errorsAgg()
    {
        $result = array();
        /** @var CActiveRecord $record */
        $record = $this->getOwner();

        if ($record->hasErrors()) {
            foreach ($record->getErrors() as $field => $errors) {
                array_push($result, get_class($record) . '_' . $field . ":" . implode(', ', $errors));
            }
        }

        return implode(';', $result);
    }
} 