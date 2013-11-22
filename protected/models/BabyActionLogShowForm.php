<?php
class BabyActionLogShowForm extends BabyActionLog
{
    public $date_start;
    public $date_end;
    public $agg;

    public function rules()
    {
        return
            array_merge(
                array(),
                parent::rules(),
                array(
                    array('baby_action_category_id', 'safe'),
                    array('date_start, date_end', 'date', 'format' => 'd.M.yyyy', 'allowEmpty' => false),
                    array('agg', 'boolean'),
                    array('id, baby_id, time_start, description , time_finish, created_at', 'unsafe'),
                )
            );
    }

    public function beforeValidate(){
        $this->time_start = date("Y-m-d 00:00:00",CDateTimeParser::parse($this->date_start,'d.M.yyyy'));
        $this->time_finish = date("Y-m-d 23:59:59",CDateTimeParser::parse($this->date_end,'d.M.yyyy'));
        return parent::beforeValidate();
    }

    public function attributeLabels()
    {
        return
            array_merge(
                parent::attributeLabels(),
                array(
                    'date_start' => Yii::t('c_app', 'From date'),
                    'date_finish' => Yii::t('c_app', 'To date'),
                    'agg' => Yii::t('c_app', 'Aggregate events'),
                )
            );
    }

    /**
     * @return array
        Example structure:
        Array
        (
            [12.11.2013] => Array
                (
                    [2] => Array
                        (
                            [color] => 777
                            [title] => Diaper change
                            [items] => Array
                                (
                                    [8] => Array
                                        (

                                            [title] => Diaper change: -
                                            [start] => 2013-11-21 12:55
                                            [finish] => 01:45

                                        )
                                    [12] => ...
                                )
                        )
                    [1] => ...
                )
            [14.11.2013] => ...
        )
     */
    public function getLog(){

        $result = array();
        $criteria = new CDbCriteria();
        $criteria->addCondition('t.time_start >= :time_start');
        $criteria->addCondition('t.time_finish <= :time_finish');
        $criteria->addCondition('t.baby_id = :baby_id');
        $criteria->order = "to_char( t.time_start, 'HH24:MI')";
        //$criteria->order = " t.time_start";
        $criteria->params = array(':time_start' => $this->time_start,':time_finish'=> $this->time_finish, ':baby_id' => $this->baby_id );
        if($this->baby_action_category_id){
            $criteria->addCondition('t.baby_action_category_id = :baby_action_category_id');
            $criteria->params = array_merge(
                $criteria->params,
                array(':baby_action_category_id' => $this->baby_action_category_id)
            );
        }


        $records = BabyActionLog::model()->with(
            array(
                'babyActionCategory' => array('together' => true)
            )
        )->findAll($criteria);

        foreach($records as $baby_log){
            /** @var $baby_log BabyActionLog */
            $date = $this->agg?
                Yii::t('c_app','All period')/*date('d.m.Y', strtotime($this->time_start)).'&mdash;'.date('d.m.Y', strtotime($this->time_finish))*/:
                date('Y.m.d', strtotime($baby_log->time_start));

            if(empty($result[$date])){
                $result[$date] = array();
            }
            $category = $baby_log->babyActionCategory;
            if(empty($result[$date][$category->id])){
                $result[$date][$category->id] = array(
                    'color' => $category->color,
                    'title' => $category->title,
                    'items' => array()
                );
            }
            $result[$date][$category->id]['items'][$baby_log->id] = array(
                'title' => $category->title.'['. date('d.m.Y', strtotime($baby_log->time_start)) .' '.date('H:i', strtotime($baby_log->time_start)).'-'.date('H:i', strtotime($baby_log->time_finish)).']: '.($baby_log->description?:'-'),
                'start' => $baby_log->time_start,
                'finish' => $baby_log->time_finish,
            );

        }
        ksort($result);
        $result = array_reverse($result);
        return $result;


    }

}