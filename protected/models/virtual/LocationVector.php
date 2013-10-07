<?php

class LocationVector extends LocationPoint {
    /** @var  LocationPoint  */
    public $pa, $pb;

    /**
     * @param $vector_str
     * @return array|null
     */
    public static function toPoints($vector_str){
        $ab = explode('::', $vector_str, 2);
        if(!is_array($ab) || count($ab) != 2) {
            return array(
                'a' => null,
                'b' => null
            );
        }
        $result = array();
        $result['a'] = $ab[0];
        $result['b'] = $ab[1];

        return $result;
    }

    /**
     * @param $vector_str
     */
    public function __construct($vector_str){
        $result = LocationVector::toPoints($vector_str);
        $this->pa = new LocationPoint($result['a']);
        $this->pb = new LocationPoint($result['b']);
    }

    /**
     * @return string
     */
    public function __toString(){
        return "{$this->pa}::{$this->pb}";
    }

    /** @var bool already optimized */
    private $optimized = false;
    /**
     * '-5:5::-10:-10' will transform to '-10:5::-5:-10'  from left-top to right-bottom
     */
    public function optimize(){
        if($this->optimized)
            return;
        $cx0 = $this->pa->cx;
        $cx1 = $this->pb->cx;

        $cy0 = $this->pa->cy;
        $cy1 = $this->pb->cy;


        if($cx0 > $cx1){
            $t = $cx0;  $cx0 = $cx1; $cx1 = $t;
            unset($t);
        }
        if($cy1 > $cy0){
            $t = $cy1;  $cy1 = $cy0; $cy0 = $t;
            unset($t);
        }

        $this->pa = new LocationPoint("$cx0:$cy0");
        $this->pb = new LocationPoint("$cx1:$cy1");
        $this->optimized = true;
    }

    /**
     * @return int
     */
    public function deltaX(){
        $this->optimize();
        return $this->pb->cx - $this->pa->cx;

    }

    /**
     * @return int
     */
    public function deltaY(){
        $this->optimize();
        return $this->pa->cy - $this->pb->cy;
    }
} 