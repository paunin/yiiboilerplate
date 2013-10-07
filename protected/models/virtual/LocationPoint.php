<?php

class LocationPoint {
    /** @var  int */
    public $cx, $cy;
    /**
     * @param $point_str
     * @return array|null
     */
    public static function toCoordinates($point_str){
        $xy = explode(':', $point_str, 2);
        if (!is_array($xy) || count($xy) != 2) {
            return array(
                'x'=>null,
                'y'=>null
            );
        }
        $result = array();
        $result['x'] = $xy[0];
        $result['y'] = $xy[1];
        return $result;
    }

    public function __construct($point_str){
        $result = LocationPoint::toCoordinates($point_str);
        $this->cx = $result['x'];
        $this->cy = $result['y'];
    }

    public function __toString(){
        return $this->cx.":".$this->cy;
    }
} 