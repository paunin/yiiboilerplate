<?php
/* @var $this ProfileController */
/* @var $model ChangePasswordForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - ' . Yii::t('c_app','Changed password');
$this->breadcrumbs=array(
    Yii::t('c_app','Changed password'),
);
?>
<div class="form  bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'changepassword-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>
    <?php //echo CHtml::errorSummary($model); ?>
    <?php if($model->getScenario()=='withpassword'): ?>
        <div class="row">
            <?php echo $form->labelEx($model,'password'); ?>
            <?php echo $form->passwordField($model,'password',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('password'))); ?>
            <?php echo $form->error($model,'password'); ?>
        </div>
    <?php endif;?>
    <div class="row">
        <?php echo $form->labelEx($model,'newpassword'); ?>
        <?php echo $form->passwordField($model,'newpassword',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('newpassword'))); ?>
        <?php echo $form->error($model,'newpassword'); ?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($model,'newpassword2'); ?>
        <?php echo $form->passwordField($model,'newpassword2',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('newpassword2'))); ?>
        <?php echo $form->error($model,'newpassword2'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton(Yii::t('c_app','Change'),array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
