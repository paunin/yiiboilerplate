<?php
Yii::import('zii.widgets.CMenu');
class b3menuWidget extends CMenu
{

    public $htmlOptions = array('class' => 'nav navbar-nav');
    public $submenuHtmlOptions = array('class' => 'dropdown-menu');

    protected function renderMenuItem($item)
    {
        if(empty($item['url'])){
            $item['url'] = "#";
            $item['itemOptions'] = array('class'=>"dropdown-header");
        }
        if(!empty($item['items']))
            $item['linkOptions'] = (array)$item['linkOptions'] + array('class'=>"dropdown-toggle", 'data-toggle'=>"dropdown");

        $label = $this->linkLabelWrapper === null ? ($item['label'] . (!empty($item['items']) ? '<b class="caret"></b>' : '')) : CHtml::tag($this->linkLabelWrapper, $this->linkLabelWrapperHtmlOptions, $item['label']);
        return CHtml::link($label, $item['url'], isset($item['linkOptions']) ? $item['linkOptions'] : array());
    }
}

