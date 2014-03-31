<?php
/* @var $this RegisterController */
/* @var $model RecoveryPassForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - '.Yii::t('c_app','Recovery password');
$this->breadcrumbs=array(
    Yii::t('c_app','Recovery password'),
);
?>
 <div class="form bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'recoverypass-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php echo $form->labelEx($model,'email'); ?>
        <?php echo $form->textField($model,'email',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('email'))); ?>
        <?php echo $form->error($model,'email'); ?>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'validacion'); ?>
        <?php $this->widget('application.extensions.recaptcha.EReCaptcha',
            array('model'=>$model, 'attribute'=>'validacion',
                'theme'=>'red', 'language'=>'es_ES',
                'publicKey'=>Yii::app()->params['captcha_public_key'])) ?>

        <?php echo $form->error($model,'validacion'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton(Yii::t('c_app','Recovery'),array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
