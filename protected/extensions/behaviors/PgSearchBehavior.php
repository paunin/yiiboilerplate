<?php

/**
 * Class PgSearchBehavior
 */
class PgSearchBehavior extends CActiveRecordBehavior
{
    /**
     * @return CActiveDataProvider
     */
    public function pgSearch()
    {

        /** @var GxActiveRecord $model */
        $model = $this->owner;
        $attributes = $model->getAttributes();
//        var_dump($attributes);
//        die();
        $criteria = new CDbCriteria;
        foreach($attributes as $atr){
            if(property_exists($model,$atr))
                $criteria->compare($atr.'::text', $model->$atr);
        }


        return new CActiveDataProvider($model, array(
            'criteria' => $criteria,
        ));
    }


} 