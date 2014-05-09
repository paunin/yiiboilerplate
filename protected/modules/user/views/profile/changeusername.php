<?php
/* @var $this ProfileController */
/* @var $model ChangeUsernameForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - ' . Yii::t('c_app','Change username');
$this->breadcrumbs=array(
    Yii::t('c_app','Change username'),
);
?>
<div class="form  bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'changeusername-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>
    <?php //echo CHtml::errorSummary($model); ?>
    <div class="row">
        <?php echo $form->labelEx($model,'username'); ?>
        <?php echo $form->textField($model,'username',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('username'))); ?>
        <?php echo $form->error($model,'username'); ?>
    </div>


    <div class="row buttons">
        <?php echo CHtml::submitButton(Yii::t('c_app','Change'),array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
