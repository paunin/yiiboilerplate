<?php
Yii::import('application.filters.Filter');
/**
 * Class Filter
 */
class ExtPreFilter extends Filter {
    public $unit;
    protected function preFilter(CFilterChain $filterChain)
    {
        // код, выполняемый до выполнения действия
        //return true; // false — для случая, когда действие не должно быть выполнено
        $this->mark('pre');
        $filterChain->run();
    }
    private function mark($mark){
        echo get_class($this).' '.$mark.' filter. Unit='.$this->unit;
    }
}

