<?php
/* @var $this RegisterController */
/* @var $model EndRecoveryPassForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - ' . Yii::t('c_app','Recovery password (new pass)');
$this->breadcrumbs=array(
    Yii::t('c_app','Recovery password (new pass)'),
);
?>
 <div class="form bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'endrecoverypass-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php //echo $form->labelEx($model,'hash'); ?>
        <?php echo $form->hiddenField($model,'hash',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('hash'))); ?>
        <?php echo $form->error($model,'hash'); ?>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'password'); ?>
        <?php echo $form->passwordField($model,'password',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('password'))); ?>
        <?php echo $form->error($model,'password'); ?>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'password2'); ?>
        <?php echo $form->passwordField($model,'password2',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('password2'))); ?>
        <?php echo $form->error($model,'password2'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton(Yii::t('c_app','Recovery'),array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
