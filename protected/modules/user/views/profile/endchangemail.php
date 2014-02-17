<?php
/* @var $this RegisterController */
/* @var $model EndRecoveryPassForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - '.  Yii::t('c_app','Changed email verify');
$this->breadcrumbs=array(
    Yii::t('c_app','Changed email verify'),
);
?>
 <div class="form bs3-form">
    <?php $form=$this->beginWidget('CActiveForm', array(
        'id'=>'endchangemail-form',
        'enableClientValidation'=>true,
        'clientOptions'=>array(
            'validateOnSubmit'=>true,
        ),
    )); ?>

    <div class="row">
        <?php echo $form->labelEx($model,'hash'); ?>
        <?php echo $form->textField($model,'hash',array('class'=>'form-control' , 'placeholder'=>$model->getAttributeLabel('hash'))); ?>
        <?php echo $form->error($model,'hash'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton( Yii::t('c_app','Change'),array('class'=>'btn btn-lg btn-primary btn-block')); ?>
    </div>

    <?php $this->endWidget(); ?>
</div><!-- form -->
