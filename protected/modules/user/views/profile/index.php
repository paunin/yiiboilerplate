<?php
/* @var $this ProfileController */
/* @var $social_accounts UserSocial[] */
$this->pageTitle = Yii::app()->name . ' - My profile';
$this->breadcrumbs = array(
    'My profile',
);
?>
<h2>Bind social account:</h2>
<?php
$this->widget('ext.eauth.EAuthWidget', array('action' => '/user/login/login'));
?>

<?php
if(count($social_accounts)):?>
    <h2>Binded accounts:</h2>
    <?php
    foreach ($social_accounts as $social_account): ?>

        <?php
        /* @var $social_account UserSocial */
        ?>

        &nbsp;<b><?php echo $social_account->social_service ?></b>:
        <?php echo $social_account->user_social_id ?>
        <?php echo CHtml::link('unbind', Cut::createUrl('user/login/unbindSocial', array('bind_id' => $social_account->id))) ?> </br>
    <?php endforeach; ?>
<?php endif; ?>
