<?php
/* @var $this RegisterController */
/* @var $model RegisterForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Registration';
$this->breadcrumbs=array(
    'Registration',
);
?>
<div class="form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'register-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php echo $form->labelEx($model,'username'); ?>
        <?php echo $form->textField($model,'username'); ?>
        <?php echo $form->error($model,'username'); ?>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'email'); ?>
        <?php echo $form->textField($model,'email'); ?>
        <?php echo $form->error($model,'email'); ?>
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
        <p class="hint">
            Hint: Password again.
        </p>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'validacion'); ?>
        <?php $this->widget('application.extensions.recaptcha.EReCaptcha',
            array('model'=>$user, 'attribute'=>'validacion',
                'theme'=>'red', 'language'=>'es_ES',
                'publicKey'=>Yii::app()->params['captcha_public_key'])) ?>

        <?php echo $form->error($model,'validacion'); ?>

    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton('Register'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
