<?php
/* @var $this ProfileController */
/* @var $social_accounts UserSocial[] */
$this->pageTitle=Yii::app()->name . ' - '.Yii::t('c_app','Current user profile');
$this->breadcrumbs=array(
    Yii::t('c_app','Current user profile'),
);
?>
Hello, <?php echo User::current()?> (IP = <?php echo Yii::app()->request->getUserHostAddress() ?>)<br/>
<!--<img src="--><?php //echo User::current()->getAvatarsPaths()['s'] ?><!--" />-->
<!--<img src="--><?php //echo User::current()->getAvatarsPaths()['m'] ?><!--" />-->
<!--<img src="--><?php //echo User::current()->getAvatarsPaths()['l'] ?><!--" />-->
<h2>Sociall accounts</h2>
<?php foreach($social_accounts as $social_account): ?>

    <?php
    /* @var $social_account UserSocial */ ?>

    <?php echo $social_account->social_service ?>:
    <?php echo $social_account->user_social_id ?>
    <?php echo CHtml::link(Yii::t('c_app','unbind'),Cut::createUrl('user/login/unbindSocial',array('bind_id'=>$social_account->id))) ?> </br>
<?php endforeach; ?>

