<?php
class CoordinateBehavior extends CActiveRecordBehavior
{
    /**
     * @var int coordinates fields
     */
    public $cx_field = 'cx';
    public $cy_field = 'cy';

    /**
     * @var int coordinates AGG fields X+Y, X-Y
     */
    public $cx_p_cy_field = 'cx_p_cy';
    public $cx_m_cy_field = 'cx_m_cy';

    public function beforeValidate($event)
    {
        /** @var CActiveRecord $record */
        $record = $this->getOwner();
        $record->setAttribute($this->cx_p_cy_field,
            (int)$record->getAttribute($this->cx_field) + (int)$record->getAttribute($this->cy_field)
        );
        $record->setAttribute($this->cx_m_cy_field,
            (int)$record->getAttribute($this->cx_field) - (int)$record->getAttribute($this->cy_field)
        );
        return parent::beforeSave($event);
    }
}

