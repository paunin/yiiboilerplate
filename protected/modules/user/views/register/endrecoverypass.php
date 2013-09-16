<?php
/* @var $this RegisterController */
/* @var $model EndRecoveryPassForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Recovery password (new pass)';
$this->breadcrumbs=array(
    'Recovery password (new pass)',
);
?>

<h1>Recovery password (new pass)</h1>

<div class="form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'endrecoverypass-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>


    <div class="row">
        <?php echo $form->labelEx($model,'hash'); ?>
        <?php echo $form->textField($model,'hash'); ?>
        <?php echo $form->error($model,'hash'); ?>
    </div>


    <div class="row">
        <?php echo $form->labelEx($model,'password'); ?>
        <?php echo $form->passwordField($model,'password'); ?>
        <?php echo $form->error($model,'password'); ?>
    </div>


    <div class="row">
        <?php echo $form->labelEx($model,'password2'); ?>
        <?php echo $form->passwordField($model,'password2'); ?>
        <?php echo $form->error($model,'password2'); ?>
    </div>


    <div class="row buttons">
        <?php echo CHtml::submitButton('Recovery'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
