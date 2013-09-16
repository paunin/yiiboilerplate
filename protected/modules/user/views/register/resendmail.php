<?php
/* @var $this RegisterController */
/* @var $model RegisterForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Resend verify eMail';
$this->breadcrumbs=array(
    'Resend verify eMail',
);
?>

<h1>Resend verify eMail</h1>

<div class="form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'resendmail-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>


    <div class="row">
        <?php echo $form->labelEx($model,'email'); ?>
        <?php echo $form->textField($model,'email'); ?>
        <?php echo $form->error($model,'email'); ?>
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
        <?php echo CHtml::submitButton('Resend'); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
