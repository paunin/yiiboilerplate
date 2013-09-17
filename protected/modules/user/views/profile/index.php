<?php
/* @var $this ProfileController */

$this->pageTitle=Yii::app()->name . ' - Current user profile';
$this->breadcrumbs=array(
    'Current user profile',
);
?>
Hello, <?php echo User::current()?> (IP = <?php echo Yii::app()->request->getUserHostAddress() ?>)<br/>

