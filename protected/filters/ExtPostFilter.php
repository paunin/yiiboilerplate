<?php
Yii::import('application.filters.Filter');
/**
 * Class Filter
 */
class ExtPostFilter extends Filter {
    public $unit;
    protected function postFilter(CFilterChain $filterChain)
    {
        $this->mark('post');
    }
    private function mark($mark){
        echo get_class($this).' '.$mark.' filter. Unit='.$this->unit;
    }
}

