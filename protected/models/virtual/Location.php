<?php

class Location extends CModel
{
    /** @var  int scale for map */
    public $scale = 1;

    public function attributeNames()
    {
        return array(
            'scale'
        );
    }

    public function rules()
    {
        return array(
            array('scale', 'application.validators.MapScaleValidator', 'integerOnly' => true),
        );
    }

    /**
     * @param LocationPoint $point
     * @param LocationPoint $nullPoint
     * @return LocationPoint
     */
    public function scalePoint(LocationPoint $point, LocationPoint $nullPoint)
    {
        $x = floor(($point->cx - $nullPoint->cx) / $this->scale);
        $y = floor(($point->cy - $nullPoint->cy) / $this->scale);

        return new LocationPoint("$x:$y");
    }

    /**
     * @param LocationPoint $point
     * @param LocationPoint $nullPoint
     * @return LocationPoint
     */
    public function unscalePoint(LocationPoint $point, LocationPoint $nullPoint)
    {
        $x = $point->cx * $this->scale + $nullPoint->cx;
        $y = $point->cy * $this->scale + $nullPoint->cy;

        return new LocationPoint("$x:$y");
    }

    /**
     * @param LocationPoint $point
     * @param LocationPoint $nullPoint
     * @return LocationVector
     */
    public function scaledVector(LocationPoint $point, LocationPoint $nullPoint)
    {
        $scalePoint = $this->scalePoint($point, $nullPoint);
        $a = $this->unscalePoint($scalePoint, $nullPoint);

        $bcx = $scalePoint->cx * $this->scale + $nullPoint->cx + $this->scale;
        $bcy = $scalePoint->cy * $this->scale + $nullPoint->cy + $this->scale;
        $vector = new LocationVector("$a::$bcx:$bcy");
        $vector->optimize();
        return $vector;
    }

    /**
     * @param LocationPoint $point
     * @param int $radius
     * @param string $table_alias
     * @return string
     */
    public function limitByRadius(LocationPoint $point, $radius = 0, $table_alias = "t")
    {
        $cx0 = $point->cx;
        $cy0 = $point->cy;
        $r = $radius;
        $r2 = ceil($radius * 1.4);

        $conditions = " ($table_alias.cx >= " . ($cx0 - $r) . " AND $table_alias.cx < " . ($cx0 + $r) . " AND $table_alias.cy >= " . ($cy0 - $r) . " AND $table_alias.cy < " . ($cy0 + $r) . ") " .
            ' AND ' .
            " ($table_alias.cx_p_cy >=  " . ($cx0 + $cy0 - $r2) . " AND $table_alias.cx_p_cy <=  " . ($cx0 + $cy0 + $r2) . " AND $table_alias.cx_m_cy >=  " . ($cx0 - $cy0 - $r2) . " AND $table_alias.cx_m_cy <=  " . ($cx0 - $cy0 + $r2) . " ) ";

        return $conditions;
    }

    /**
     * @param LocationVector $vector
     * @param $table_alias
     * @return string
     */
    public function limitByVector(LocationVector $vector, $table_alias = "t")
    {
        $vector->optimize();
        return " ($table_alias.cx >= {$vector->pa->cx} AND $table_alias.cx < {$vector->pb->cx} AND $table_alias.cy >= {$vector->pb->cy} AND $table_alias.cy < {$vector->pa->cy}) ";
    }
}