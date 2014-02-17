<?php
/* @var $this LoginController */
/* @var $model LoginForm */
/* @var $form CActiveForm */

$this->pageTitle = Yii::app()->name . ' - '.Yii::t('c_app','Login');
$this->breadcrumbs = false;

?>

<div class="form bs3-form">
    <?php $form = $this->beginWidget('CActiveForm', array(
        'id' => 'login-form',
        'enableClientValidation' => true,
        'clientOptions' => array(
            'validateOnSubmit' => true,
        ),
    )); ?>

    <div class="row">
        <?php echo $form->labelEx($model,'username'); ?>
        <?php echo $form->textField($model, 'username', array('class' => 'form-control', 'placeholder' => $model->getAttributeLabel('username'))); ?>
        <?php echo $form->error($model, 'username'); ?>
    </div>

    <div class="row">
        <?php echo $form->labelEx($model,'password'); ?>
        <?php echo $form->passwordField($model, 'password', array('class' => 'form-control', 'placeholder' => $model->getAttributeLabel('password'))); ?>
        <?php echo $form->error($model, 'password'); ?>
    </div>

    <div class="row rememberMe">
        <?php echo $form->checkBox($model, 'rememberMe'); ?>
        <?php echo $form->label($model, 'rememberMe'); ?>
        <?php echo $form->error($model, 'rememberMe'); ?>
    </div>

    <div class="row buttons">
        <?php echo CHtml::submitButton(Yii::t('c_app','Login'), array('class' => 'btn btn-lg btn-primary btn-block')); ?>
    </div>
    <div class="row rememberMe" style="text-align: center">
        <?php echo CHtml::link(Yii::t('c_app', 'Recovery password'), Cut::createUrl('/user/register/recoverypass')) ?> |
        <?php echo CHtml::link(Yii::t('c_app', 'Resend registration email'), Cut::createUrl('/user/register/resendmail')) ?> |
        <?php echo CHtml::mailto(Yii::t('c_app', 'Support'), Yii::app()->params['adminEmail']) ?>


    </div>

    <div style="text-align: center; margin: auto">
        </br>
        </br>
        </br>
        <?php Yii::t('c_app','OR USE ONE OF YOUR SOCIAL ACCOUNTS')?></br></br></br>
        <?php
        $this->widget('ext.eauth.EAuthWidget', array('action' => '/user/login/login'));
        ?>
        </br>
        </br>
        </br>
        <?php Yii::t('c_app','OR USE SIGNUP FORM TO GET NEW ACCOUNT')?>
        </br>
        </br>
        </br>
        </br>

        <?php echo CHtml::link('Register', Cut::createUrl('/user/register/register'), array('class' => 'btn btn-lg btn-primary btn-block')); ?>


    </div>
    <?php $this->endWidget(); ?>
</div><!-- form -->

