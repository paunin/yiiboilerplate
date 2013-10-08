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

    /** @var  bool */
    public $with_spirits;
    public $just_count;

    public function attributeNames()
    {
        return array(
            'vector',
            'point',
            'radius',
            'scale',
            'with_spirits'
        );
    }


    public function rules()
    {
        return
            array_merge(
                parent::rules(),
                array(
                    array('with_spirits, just_count', 'boolean'),

                    array('point', 'application.validators.CoordinatePointValidator', 'on' => 'radius_limit'),
                    array('radius', 'application.validators.RadiusValidator', 'on' => 'radius_limit'),

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
     * @return array
     */
    public function buildProfileMap()
    {
        $base_vector = $this->getBaseVector();
        $sql = '
            SELECT
                t.cx, t.cy, t.is_spirit,
                u.id,u.username,u.email, u.created_at,u.last_login
            FROM
                user_place t
            JOIN "user" u ON t.user_id = u.id
            WHERE (' . $this->makeLimits() . ') ' . (!$this->with_spirits ? ' AND t.is_spirit = false' : '') . '
            ORDER BY t.cx, t.cy
        ';
        $command = Yii::app()->db->createCommand($sql);

        $dataReader = $command->query();
        $result = array();

        while (($row = $dataReader->read()) !== false) {

            $point = new LocationPoint("{$row['cx']}:{$row['cy']}");
            $scaledPoint = $this->scalePoint($point, $base_vector->pa);

            $scaledVector = $this->scaledVector($point, $base_vector->pa);


            if (empty($result["$scaledPoint"])) {
                $result["$scaledPoint"] =
                    array(
                        "real_cxyxy" => "$scaledVector",
                        "scale_cxy" => "$scaledPoint",
                        'profiles' => $this->just_count ? 0 : array(),
                        'spirits' => $this->just_count ? 0 : array()
                    );
            }


            if (!$this->just_count) {
                $profile = array(
                    'id' => $row['id'],
                    'username' => $row['username'],
                    'name' => null,
                    'avatar' => null,
                    'created_at' => $row['created_at'],
                    'last_login' => $row['last_login'],
                );
                if (!$row['is_spirit']) {
                    if (empty($result["$scaledPoint"]['profiles']["$point"])) {
                        $result["$scaledPoint"]['profiles']["$point"] = array();
                    }
                    $result["$scaledPoint"]['profiles']["$point"][] = $profile;
                } else {
                    if (empty($result["$scaledPoint"]['spirits']["$point"])) {
                        $result["$scaledPoint"]['spirits']["$point"] = array();
                    }
                    $result["$scaledPoint"]['spirits']["$point"][] = $profile;
                }
            } else {
                if (!$row['is_spirit']) {
                    $result["$scaledPoint"]['profiles'] += 1;
                } else {
                    $result["$scaledPoint"]['spirits'] += 1;
                }

            }
        }
        return $result;
    }

    /**
     * @return string
     */
    private function makeLimits()
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

    private function getBaseVector()
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