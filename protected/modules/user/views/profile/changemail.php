<?php
/* @var $this ProfileController */
/* @var $model ChangeMailForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Change email';
$this->breadcrumbs=array(
    'Change email',
);
?>
<div class="form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'changemail-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php echo $form->labelEx($model,'newemail'); ?>
        <?php echo $form->textField($model,'newemail'); ?>
        <?php echo $form->error($model,'newemail'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton('Change'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
