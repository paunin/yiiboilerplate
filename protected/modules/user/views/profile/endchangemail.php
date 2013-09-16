<?php
/* @var $this RegisterController */
/* @var $model EndRecoveryPassForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Changed email verify';
$this->breadcrumbs=array(
    'Changed email verify',
);
?>

<h1>Changed email verify</h1>

<div class="form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'endchangemail-form',
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


    <div class="row buttons">
        <?php echo CHtml::submitButton('Change'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->