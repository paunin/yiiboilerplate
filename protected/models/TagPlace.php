<?php

Yii::import('application.models._base.BaseTagPlace');

class TagPlace extends BaseTagPlace
{
    public $point;
    public $tag_name;

    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            array(
                array('point', 'required', 'on' => 'tag_place_post'),
                array('point', 'application.validators.CoordinatePointValidator', 'on' => 'tag_place_post', 'makeCoordinates' => true),
                array('tag_name', 'application.validators.TagStringValidator', 'on' => 'tag_place_post'),
                array('tag_name', 'application.validators.TagValidator', 'on' => 'tag_place_post', 'createIfNotFound' => true, 'makeId' => true),
                array('tag_name', 'checkAround', 'on' => 'tag_place_post'),
            ),
            parent::rules(),
            array(
                array('user_id', 'exist', 'attributeName' => 'id', 'className' => 'User'),
                array('tag_id', 'exist', 'attributeName' => 'id', 'className' => 'Tag'),
                array('user_id, tag_id, cx, cy, cx_p_cy, cx_m_cy', 'unsafe', 'on' => 'tag_place_post'),
            )
        );
    }

    /**
     * @param $attribute
     * @param $params
     */
    public function checkAround($attribute, $params)
    {

        $radius = Radius::getTagRadius();
        $tagMap = new TagLocationMap();
        $tagMap->setScenario('radius_limit');
        $tagMap->radius = $radius;
        $tagMap->point = $this->point;
        if($tagMap->validate()) {
            if($tagMap->findForUser($this->user_id, $this->tag_name))
                $this->addError($attribute, Yii::t('app', 'You already have this tag somewhere here'));
        } else {
            $this->addError($attribute, $tagMap->errorsAgg());
        }


    }

    /**
     * @return array
     */
    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
            'WeightBehavior' => array(
                'class' => 'ext.behaviors.WeightBehavior'
            )
        );
    }

    /**
     * @param int $delta
     * @param bool $self update current TagPlace weight
     * @return int current TagPlace weight
     * @throws CException
     */
    public function recountWeights($delta, $self = true)
    {
        $map = new TagLocationMap();
        $map->setScenario('radius_limit');
        $map->point = $this->cx . ':' . $this->cy;
        $map->radius = Radius::getTagRadius();
        if($map->validate()) {
            $sql = <<<SQL
            UPDATE
                tag_place
            SET
              weight = weight +$delta
            WHERE ({$map->makeLimits("tag_place")}) AND tag_id = :tag_id
SQL;

            $current_weight = Yii::app()->db->createCommand($sql)->execute(array(":tag_id" => $this->tag_id));
        } else {
            throw new CException('recountWeights Error');
        }

        if($self){
            $this->weight = $current_weight;
            $this->save();
        }
        return $current_weight;

    }
}