<?php

class LocationMap extends Location
{
    /** @var string in format '-5:5::5:5' is ok '-5:5::-10:-10' will transform to '-10:5::-5:-10' */
    public $vector;
    public $with_spirits;

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
                    array('with_spirits','boolean'),
                )
            );
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
            WHERE true ' . (!$this->with_spirits ? ' AND t.is_spirit = false' : '') . '
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
                        'profiles' => array(),
                        'spirits' => array()

                    
                );
            }

            $profile = array(
                'id' => $row['id'],
                'username' => $row['username'],
                'name' => null,
                'avatar' => null,
                'created_at' => $row['created_at'],
                'last_login' => $row['last_login'],
                'user_social' => Array()
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




        }
        return $result;
    }

    public function scalePoint(LocationPoint $point)
    {
        $x = floor(($point->cx - $this->cx0) / $this->scale);
        $y = floor(($point->cy - $this->cy0) / $this->scale);

        return new LocationPoint("$x:$y");
    }

    public function unscalePoint(LocationPoint $point){
        $x = $point->cx * $this->scale + $this->cx0;
        $y = $point->cy * $this->scale + $this->cy0;

        return new LocationPoint("$x:$y");
    }

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