<?php

class LocationMap extends Location
{

    /** FOR VECTOR LIMITATION */
    /** @var string in format '-5:5::5:5' is ok '-5:5::-10:-10' will transform to '-10:5::-5:-10' */
    public $vector;

    /** FOR RADIUS LIMITATION */
    /** @var  string */
    public $point;
    /** @var  int */
    public $radius;



    public function attributeNames()
    {
        return array(
            'vector',
            'point',
            'radius',
            'scale'
        );
    }


    public function rules()
    {
        return
            array_merge(
                parent::rules(),
                array(
                    array('point', 'application.validators.CoordinatePointValidator', 'on' => 'radius_limit'),
                    array('radius', 'application.validators.RadiusValidator', 'createOnEmpty'=>true, 'on' => 'radius_limit'),

                    array('vector', 'application.validators.CoordinateVectorValidator', 'optimize' => true, 'makeCoordinates' => false, 'on' => 'vector_limit'),
                    array('scale', 'checkResolution', 'on' => 'vector_limit')
                )
            );
    }

    /**
     * @param string $attribute
     * @param array $params
     */
    public function checkResolution($attribute, $params)
    {
        if (!$this->hasErrors('vector') && !$this->hasErrors('scale')) {
            //%ШИРИНА КАРТЫ% / scale <= config.map_resolution_max AND %ВЫСОТА КАРТЫ% / scale <= config.map_resolution_max
            $vector = new LocationVector($this->vector);
            if (
                $vector->deltaX() / $this->$attribute > Yii::app()->params['map_resolution_max'] ||
                $vector->deltaY() / $this->$attribute > Yii::app()->params['map_resolution_max']
            )
                $this->addError('scale', Yii::t('app', 'Resolution is too high (maximum resolution - {max_resolution})', array('{max_resolution}' => Yii::app()->params['map_resolution_max'])));
        }

    }

    /**
     * @return string
     */
    protected function makeLimits()
    {
        switch ($this->getScenario()) {
            case 'vector_limit':
                $conditions = $this->limitByVector(new LocationVector($this->vector));
                break;
            case 'radius_limit':

                $conditions = $this->limitByRadius(new LocationPoint($this->point), $this->radius);
                break;
        }
        return $conditions;
    }

    protected function getBaseVector()
    {
        switch ($this->getScenario()) {
            case 'vector_limit':
                $v = new LocationVector($this->vector);
                break;
            case 'radius_limit':
                $p = new LocationPoint($this->point);
                $pa = new LocationPoint(($p->cx - $this->radius) . ':' . ($p->cy - $this->radius));
                $pb = new LocationPoint(($p->cx + $this->radius) . ':' . ($p->cy + $this->radius));

                $v = new LocationVector("$pa::$pb");
                break;
        }
        $v->optimize();
        return $v;
    }

} 