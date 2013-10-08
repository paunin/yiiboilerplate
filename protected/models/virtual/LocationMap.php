<?php

class LocationMap extends Location
{
    /** @var string in format '-5:5::5:5' is ok '-5:5::-10:-10' will transform to '-10:5::-5:-10' */
    public $vector;

    /** @var  bool */
    public $with_spirits;
    public $just_count;

    /** @var  int Coordinates */
    public $cx0, $cy0, $cx1, $cy1;
    /** @var  string A and B points coordinates */
    public $pa, $pb;

    public function attributeNames()
    {
        return array(
            'vector',
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
                    array('vector', 'application.validators.CoordinateVectorValidator', 'optimize' => true, 'makeCoordinates' => true),
                    array('with_spirits, just_count','boolean'),
                    array('scale','checkResolution')
                )
            );
    }

    /**
     * @param string $attribute
     * @param array $params
     */
    public function checkResolution($attribute, $params)
    {
        if(!$this->hasErrors('vector') && !$this->hasErrors('scale')){
            //%ШИРИНА КАРТЫ% / scale <= config.map_resolution_max AND %ВЫСОТА КАРТЫ% / scale <= config.map_resolution_max
            $vector = new LocationVector($this->vector);
            if(
                $vector->deltaX()/$this->$attribute > Yii::app()->params['map_resolution_max'] ||
                $vector->deltaY()/$this->$attribute > Yii::app()->params['map_resolution_max']
            )
                $this->addError('scale', Yii::t('app', 'Resolution is too high (maximum resolution - {max_resolution})',array('{max_resolution}'=>Yii::app()->params['map_resolution_max'])));
        }

    }
    /**
     * @return array
     */
    public function buildProfileMap()
    {

        $command = Yii::app()->db->createCommand('
            SELECT
                t.cx, t.cy, t.is_spirit,
                u.id,u.username,u.email, u.created_at,u.last_login
            FROM
                user_place t
            JOIN "user" u ON t.user_id = u.id
            WHERE ('.$this->limitByVector(new LocationVector($this->vector)).') ' . (!$this->with_spirits ? ' AND t.is_spirit = false' : '') . '
            ORDER BY t.cx, t.cy
        ');

        $dataReader = $command->query();
        $result = array();

        while (($row = $dataReader->read()) !== false) {

            $point = new LocationPoint("{$row['cx']}:{$row['cy']}");
            $scaledPoint = $this->scalePoint($point);

            $scaledVector = $this->scaledVector($point);



            if(empty($result["$scaledPoint"])) {
                $result["$scaledPoint"] =
                    array(
                        "real_cxyxy" => "$scaledVector",
                        "scale_cxy" => "$scaledPoint",
                        'profiles' => $this->just_count?0:array(),
                        'spirits' => $this->just_count?0:array()
                );
            }


            if(!$this->just_count){
                $profile = array(
                    'id' => $row['id'],
                    'username' => $row['username'],
                    'name' => null,
                    'avatar' => null,
                    'created_at' => $row['created_at'],
                    'last_login' => $row['last_login'],
                );
                if(!$row['is_spirit']) {
                    if(empty($result["$scaledPoint"]['profiles']["$point"])) {
                        $result["$scaledPoint"]['profiles']["$point"] = array();
                    }
                    $result["$scaledPoint"]['profiles']["$point"][] = $profile;
                } else {
                    if(empty($result["$scaledPoint"]['spirits']["$point"])) {
                        $result["$scaledPoint"]['spirits']["$point"] = array();
                    }
                    $result["$scaledPoint"]['spirits']["$point"][] = $profile;
                }
            } else {
                if(!$row['is_spirit']) {
                    $result["$scaledPoint"]['profiles'] += 1;
                }else{
                    $result["$scaledPoint"]['spirits'] += 1;
                }

            }
        }
        return $result;
    }

    /**
     * limitation by vector
     *
     * @param LocationVector $vector
     * @return string
     */
    public function limitByVector(LocationVector $vector){
        $vector->optimize();
        return "cx >= {$vector->pa->cx} AND cx < {$vector->pb->cx} AND cy >= {$vector->pb->cy} AND cy < {$vector->pa->cy}";
    }

    /**
     * @param LocationPoint $point
     * @return LocationPoint
     */
    public function scalePoint(LocationPoint $point)
    {
        $x = floor(($point->cx - $this->cx0) / $this->scale);
        $y = floor(($point->cy - $this->cy0) / $this->scale);

        return new LocationPoint("$x:$y");
    }

    /**
     * @param LocationPoint $point
     * @return LocationPoint
     */
    public function unscalePoint(LocationPoint $point){
        $x = $point->cx * $this->scale + $this->cx0;
        $y = $point->cy * $this->scale + $this->cy0;

        return new LocationPoint("$x:$y");
    }

    /**
     * @param LocationPoint $point
     * @return LocationVector
     */
    public function scaledVector(LocationPoint $point){
        $scalePoint = $this->scalePoint($point);
        $a = $this->unscalePoint($scalePoint);

        $bcx = $scalePoint->cx * $this->scale + $this->cx0 + $this->scale;
        $bcy = $scalePoint->cy * $this->scale + $this->cy0 + $this->scale;
        $vector = new LocationVector("$a::$bcx:$bcy");
        $vector->optimize();
        return $vector;
    }

} 