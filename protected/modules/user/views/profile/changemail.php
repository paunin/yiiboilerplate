<?php
/* @var $this ProfileController */
/* @var $model ChangeMailForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Change email';
$this->breadcrumbs=array(
    'Change email',
);
?>
<div class="form  bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'changemail-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php //echo $form->labelEx($model,'newemail'); ?>
        <?php echo $form->textField($model,'newemail',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('newemail'))); ?>
        <?php echo $form->error($model,'newemail'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton('Change',array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
