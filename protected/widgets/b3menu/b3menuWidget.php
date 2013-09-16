<?php
Yii::import('zii.widgets.CMenu');
class b3menuWidget extends CMenu
{

    public $htmlOptions = array('class' => 'nav navbar-nav');
    public $submenuHtmlOptions = array('class' => 'dropdown-menu');

    /**
     * @see CMenu::renderMenuItem
     *
     * @param array $item
     * @param int $level
     * @return string
     */
    protected function renderMenuItem($item,$level = 0)
    {

        if(!empty($item['items']))
            $item['linkOptions'] = (array)$item['linkOptions'] + array('class'=>"dropdown-toggle", 'data-toggle'=>"dropdown");
        if(empty($item['label']))
            $item['label'] = '';

        $label = $this->linkLabelWrapper === null ? ($item['label'] . (!empty($item['items']) ? '<b class="caret"></b>' : '')) : CHtml::tag($this->linkLabelWrapper, $this->linkLabelWrapperHtmlOptions, $item['label']);

        if(empty($item['url'])){
            if($level > 0)
                return $label;
            else
                $item['url'] = "#";
        }
        return CHtml::link($label, $item['url'], isset($item['linkOptions']) ? $item['linkOptions'] : array());
    }

    /**
     * @see CMenu::renderMenuRecursive
     *
     * @param array $items
     * @param int $level
     */
    protected function renderMenuRecursive($items,$level = 0)
    {
        $count=0;
        $n=count($items);
        foreach($items as $item)
        {
            $count++;
            $options=isset($item['itemOptions']) ? $item['itemOptions'] : array();

            if($level > 0 && (empty($item['label'])||$item['label']=='-')){
                $options = $options +  array('class'=>"divider");
            }
            elseif($level > 0 && empty($item['url'])){
                $options = $options +  array('class'=>"dropdown-header");
            }


            $class=array();
            if($item['active'] && $this->activeCssClass!='')
                $class[]=$this->activeCssClass;
            if($count===1 && $this->firstItemCssClass!==null)
                $class[]=$this->firstItemCssClass;
            if($count===$n && $this->lastItemCssClass!==null)
                $class[]=$this->lastItemCssClass;
            if($this->itemCssClass!==null)
                $class[]=$this->itemCssClass;
            if($class!==array())
            {
                if(empty($options['class']))
                    $options['class']=implode(' ',$class);
                else
                    $options['class'].=' '.implode(' ',$class);
            }

            echo CHtml::openTag('li', $options);

            $menu=$this->renderMenuItem($item,$level);
            if(isset($this->itemTemplate) || isset($item['template']))
            {
                $template=isset($item['template']) ? $item['template'] : $this->itemTemplate;
                echo strtr($template,array('{menu}'=>$menu));
            }
            else
                echo $menu;

            if(isset($item['items']) && count($item['items']))
            {
                echo "\n".CHtml::openTag('ul',isset($item['submenuOptions']) ? $item['submenuOptions'] : $this->submenuHtmlOptions)."\n";
                $this->renderMenuRecursive($item['items'],$level+1);
                echo CHtml::closeTag('ul')."\n";
            }

            echo CHtml::closeTag('li')."\n";
        }
    }
}

