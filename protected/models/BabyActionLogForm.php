<?php
class BabyActionLogForm extends BabyActionLog
{
    public $start, $finish, $date;

    public function rules()
    {
        return
            array_merge(
                array(),
                parent::rules(),
                array(
                    array('baby_action_category_id, date, start,','required'),
                    array('start','date','format'=>'h:m'),
                    array('finish','date','format'=>'h:m'),
                    array('date','date','format'=>'d.M.yyyy'),
                    array('id, baby_id, time_start, time_finish, created_at', 'unsafe'),
                )
            );
    }

    public function beforeValidate(){
        return parent::beforeValidate();
    }

    public function beforeSave(){
        if(!$this->finish)
            $this->finish = $this->start;

        $this->setAttribute('time_start',$this->getAttribute('date').' '.$this->getAttribute('start'));
        $this->setAttribute('time_finish',$this->getAttribute('date').' '.$this->getAttribute('finish'));
        $this->time_start = date("Y-m-d H:i:s",CDateTimeParser::parse($this->time_start,'d.M.yyyy h:m'));
        $this->time_finish = date("Y-m-d H:i:s",CDateTimeParser::parse($this->time_finish,'d.M.yyyy h:m'));
        return parent::beforeSave();
    }

    public function attributeLabels()
    {
        return
            array_merge(
                parent::attributeLabels(),
                array(
                    'time_start' => Yii::t('c_app', 'Start'),
			        'time_finish' => Yii::t('c_app', 'Finish'),
			        'description' => Yii::t('c_app', 'Note'),
                )
            );
    }

}