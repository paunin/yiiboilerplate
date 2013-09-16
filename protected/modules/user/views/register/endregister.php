<?php
/* @var $this RegisterController */
/* @var $model EndRegisterForm */
/* @var $form CActiveForm */

$this->pageTitle = Yii::app()->name . ' - Registration(Verify email)';
$this->breadcrumbs = array(
    'Registration(Verify email)',
);
?>
<div class="form">
    <?php $form = $this->beginWidget('CActiveForm', array(
        'id' => 'endregister-form',
        'enableClientValidation' => true,
        'clientOptions' => array(
            'validateOnSubmit' => true,
        ),
    )); ?>

     <div class="row">
        <?php echo $form->labelEx($model, 'hash'); ?>
        <?php echo $form->textField($model, 'hash'); ?>
        <?php echo $form->error($model, 'hash'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton('Submit'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
