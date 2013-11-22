<?php
/** @var $model BabyActionLogForm */
/** @var $modelShow BabyActionLogShowForm */
/** @var $baby Baby */
/** @var $stat array */
/** @var $form CActiveForm */

Asse::addCss('baby_action_log_form.css');
Asse::addCss('baby_action_log.css');

Asse::addJs('jquery.tipsy.js',Yii::getPathOfAlias('webroot.web.tipsy.src.javascripts'));
Asse::addCss('tipsy.css',Yii::getPathOfAlias('webroot.web.tipsy.src.stylesheets'));

$this->pageTitle = $baby->name . ' - ' . Yii::app()->name;
$this->breadcrumbs = array(
    Yii::t('c_app','My babies')=>'baby/index',
    $baby->name,
);
?>
<link rel="stylesheet" type="text/css"
      href="<?php echo Yii::app()->request->baseUrl; ?>/web/bootstrap_helpers/dist/css/bootstrap-formhelpers.min.css"
      xmlns="http://www.w3.org/1999/html"/>
<script type="text/javascript"
        src="<?php echo Yii::app()->request->baseUrl; ?>/web/bootstrap_helpers/dist/js/bootstrap-formhelpers.js"></script>
<div>
<?php $form = $this->beginWidget('CActiveForm', array(
    'id' => 'baby-action-log-form',
    'htmlOptions' => array('class' => 'form-inline', 'role' => 'form', 'style' => "float: right; margin-top: 10px"),
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
    ),
)); ?>


<div class="form-group form-add-event-title">
    Add event
</div>
<div class="form-group">
    <?php
    $list = CHtml::listData(BabyActionCategory::model()->findAll(), 'id', 'title');
    $list = array('' => '...') + $list;
    echo CHtml::activeDropDownList($model, 'baby_action_category_id',
        $list,
        array('class' => "form-control category")) ?>

</div>
<div class="form-group">
    <div class="bfh-timepicker time"
         id="<?php echo CHtml::activeId($model, 'start') ?>"
         data-name="<?php echo CHtml::activeName($model, 'start') ?>"
         placeholder="<?php echo $model->getAttributeLabel('start') ?>">
    </div>
    <input hidden="hidden"
           id="<?php echo CHtml::activeId($model, 'start') ?>_real"
           data-id="<?php echo CHtml::activeId($model, 'start') ?>"
           class="real-value"
           value="<?php echo $model->getAttribute('start') ?>">
</div>
<div class="form-group">
    &mdash;
</div>

<div class="form-group">
    <div class="bfh-timepicker time"
         id="<?php echo CHtml::activeId($model, 'finish') ?>"
         data-name="<?php echo CHtml::activeName($model, 'finish') ?>"
         placeholder="<?php echo $model->getAttributeLabel('finish') ?>">
    </div>
    <input hidden="hidden"
           id="<?php echo CHtml::activeId($model, 'finish') ?>_real"
           data-id="<?php echo CHtml::activeId($model, 'finish') ?>"
           class="real-value"
           value="<?php echo $model->getAttribute('finish') ?>">
</div>

<div class="form-group">
    <div class="bfh-datepicker date"
         id="<?php echo CHtml::activeId($model, 'date') ?>"
         data-name="<?php echo CHtml::activeName($model, 'date') ?>"
         data-format="d.m.y"
         placeholder="<?php echo $model->getAttributeLabel('date') ?>">
    </div>
    <input hidden="hidden"
           id="<?php echo CHtml::activeId($model, 'date') ?>_real"
           data-id="<?php echo CHtml::activeId($model, 'date') ?>"
           class="real-value"
           value="<?php echo $model->getAttribute('date') ?>">
</div>

<div class="form-group">
    <?php echo $form->textField($model, 'description', array('class' => 'form-control note', 'placeholder' => $model->getAttributeLabel('description'))); ?>
</div>

<button type="submit" class="btn btn-default"><?php echo Yii::t('c_app', 'Add') ?></button>
<?php if($model->errors) Cut::setFlash($form->errorSummary($model), 'error'); ?>
<?php $this->endWidget(); ?>

<script type="text/javascript">
    $(document).ready(function () {
        setTimeout(function () {
            $('input.real-value').each(function () {
                $('#' + $(this).data('id')).find('input.form-control').val($(this).val());
                $('.bfh-datepicker, .bfh-timepicker').find('input').removeAttr('readonly');
            })
        }, 300)
    })
</script>


<br/>
<br/>
<br/>
<br/>
<hr/>

<?php $form = $this->beginWidget('CActiveForm', array(
    'method' => 'get',
    'action' => Cut::createUrl('baby/baby'),
    'id' => 'baby-action-log-show-form',
    'htmlOptions' => array('class' => 'form-inline', 'role' => 'form', 'style' => "float: right; margin-top: 10px"),
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
    ),
)); ?>

<div class="form-group">
    <?php
    $list = CHtml::listData(BabyActionCategory::model()->findAll(), 'id', 'title');
    $list = array('' => Yii::t('c_app', 'All')) + $list;
    echo CHtml::activeDropDownList($modelShow, 'baby_action_category_id',
        $list,
        array('class' => "form-control category")) ?>

</div>
<div class="form-group">
    <div class="bfh-datepicker date"
         id="<?php echo CHtml::activeId($modelShow, 'date_start') ?>"
         data-name="<?php echo CHtml::activeName($modelShow, 'date_start') ?>"
         data-format="d.m.y"
         placeholder="<?php echo $modelShow->getAttributeLabel('date_start') ?>">

    </div>
    <input hidden="hidden"
           id="<?php echo CHtml::activeId($modelShow, 'date_start') ?>_real"
           data-id="<?php echo CHtml::activeId($modelShow, 'date_start') ?>"
           class="real-value"
           value="<?php echo $modelShow->getAttribute('date_start') ?>">
</div>
<div class="form-group">
    &mdash;
</div>

<div class="form-group">
    <div class="bfh-datepicker date"
         id="<?php echo CHtml::activeId($modelShow, 'date_end') ?>"
         data-name="<?php echo CHtml::activeName($modelShow, 'date_end') ?>"
         data-format="d.m.y"
         placeholder="<?php echo $modelShow->getAttributeLabel('date_end') ?>">
    </div>
    <input hidden="hidden"
           id="<?php echo CHtml::activeId($modelShow, 'date_end') ?>_real"
           data-id="<?php echo CHtml::activeId($modelShow, 'date_end') ?>"
           class="real-value"
           value="<?php echo $modelShow->getAttribute('date_end') ?>">
</div>

<div class="form-group">
    <label class="checkbox-inline">
        <div class="checkbox">
            <?php echo $form->checkBox($modelShow, 'agg', array('class' => 'agg', 'placeholder' => $modelShow->getAttributeLabel('agg'))); ?>
            <?php echo $modelShow->getAttributeLabel('agg') ?>&nbsp;&nbsp;&nbsp;
        </div>
    </label>
</div>


<button type="submit" class="btn btn-primary"><?php echo Yii::t('c_app', 'Show events') ?></button>
<?php if($modelShow->errors) Cut::setFlash($form->errorSummary($modelShow), 'error'); ?>
<?php $this->endWidget(); ?>
<br/>
<br/>
<br/>
<br/>
<?php if(empty($stat)): ?>
    <h2 class="empty-stat"><?php echo Yii::t('c_app', 'No information about your baby. Check filters or add some events.') ?></h2>
<?php endif; ?>

<?php foreach ($stat as $date => $cats): ?>
    <div class="chart-element">
        <hr class="clear"/>
        <div class="chart-element-date"><?php echo $date ?></div>

        <?php foreach ($cats as $cat_id => $cat): ?>
            <div class="chart-group">

                <ul class="chart-element-bar<?php echo $modelShow->agg ? ' chart-agg' : '' ?>"
                    data-color="#<?php echo $cat['color'] ?>"
                    data-category-id="<?php echo $cat_id ?>"
                    data-title="<?php echo $cat['title'] ?>">

                    <?php foreach ($cat['items'] as $item_id => $item): ?>

                        <li class="chart-element-time"
                            data-id="<?php echo $item_id ?>"
                            data-start="<?php echo date('H:i', strtotime($item['start'])) ?>"
                            data-end="<?php echo date('H:i', strtotime($item['finish'])) ?>">
                            <div class="chart chart-mini tipsyt" data-tipsy-g="s" title="<?php echo $item['title'] ?>">
                                <span class="title-log">
                                    [<?php echo date('H:i', strtotime($item['start'])) ?> - <?php echo date('H:i', strtotime($item['finish'])) ?>]
                                    <a href="<?php echo Cut::createUrl('baby/deleteLog',array('id'=>$item_id)) ?>"
                                       class="delete-log tipsyt"  data-tipsy-g="nw" title="<?php echo Yii::t('c_app','Delete event') ?>">
                                        del
                                    </a>
                                </span>
                            </div>
                        </li>
                    <?php endforeach; ?>

                </ul>
                <div class="chart-element-actions">
                    <a href="#"
                       class="expand-log tipsyt"
                       title="<?php echo Yii::t('c_app','Show/hide all events') ?>"
                       data-tipsy-g="w" >
                        <img src="<?php echo Yii::app()->request->baseUrl; ?>/images/expand.gif">
                    </a>
                </div>
            </div>
            <br class="clear"/>
        <?php endforeach; ?>


    </div>
<?php endforeach; ?>



<script type="text/javascript">
    $(document).ready(function () {

        $('.tipsyt')
            .each(function(){
                var g = $(this).data('tipsy-g');
                if(g)
                    $(this).tipsy({gravity: g})
                else
                    $(this).tipsy({gravity: 's'})
            });

        $('.chart-element-bar').each(function () {
            var color = $(this).data('color');
            $(this).css('border-color', color);
            $(this).find('.chart-element-time').each(function () {

                var start = $(this).data('start').split(':', 2);
                var end = $(this).data('end').split(':', 2);

                var start_point = (parseInt(start[0]) * 60 + parseInt(start[1])) / 2;
                var end_point = (parseInt(end[0]) * 60 + parseInt(end[1])) / 2;

                var len = end_point - start_point;
                if (len <= 0) {
                    start_point = start_point-2
                    len = 2;
                    var local_color = "#aaa"
                }
                $(this).find('.chart').css('background-color', local_color ? local_color : color)
                                      .css('left', start_point + 'px')
                                      .width(len + 'px');

                $(this).click(function () {
                    $(this).parents('.chart-group').find('.expand-log').click();
                    return false;
                })
            })
        })

        $('a.expand-log').click(function () {

            if($(this).hasClass('active')){
                $(this).parents('.chart-group')
                            .animate({'height':'16px'},'slow')
                            .find('.chart-element-bar')
                                .animate({'height':'10px'},'slow',function(){
                                    $(this).removeClass('chart-element-bar-expanded');
                                })
                            .end()
                            .find('.chart-element-time')
                                .each(function(index, value){
                                    $(this).animate({'top':0},function(){
                                        if($(this).hasClass('chart-element-time-deleted'))
                                            $(this).remove();
                                    })
                                    $(this).find('.chart').addClass('chart-mini');
                                    $(this).find('.chart').animate({'height':'9px'});
                                })
            } else {
                var count = $(this).parents('.chart-group').find('.chart-element-time').length;
                if(!count)
                    count = 1;

                $(this).parents('.chart-group')
                            .animate({'height':(count) * 20 + 10 +'px'},'fast')
                            .find('.chart-element-bar')
                                .addClass('chart-element-bar-expanded')
                            .end()
                            .find('.chart-element-bar')
                                .animate({'height':((count) * 20)-3 +'px'},'fast')
                            .end()
                            .find('.chart-element-time')
                                .each(function(index, value){
                                    $(this).animate({'top':(index+0) * 20 +'px'})
                                    $(this).find('.chart').animate({'height':'15px'},'fast',function(){
                                        $(this).removeClass('chart-mini');
                                    });
                                })
            }
            $(this).toggleClass('active');
            return false;
        })

        $('a.delete-log').click(function (){
            $(this).hide().parents('.chart-element-time').addClass('chart-element-time-deleted');
            $.ajax({
                type: "POST",
                url: $(this).attr('href'),
                dataType: "json",
                success: function(data){
                    //success
                }
            });
            return false;
        })

    })
</script>
</div>