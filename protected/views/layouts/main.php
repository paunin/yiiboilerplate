<?php
Asse::addCss('main.css');

Asse::addCss('bootstrap.min.css',Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
Asse::addCss('bootstrap-theme.min.css',Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
Asse::addJs('jquery/jquery-1.10.2.min.js');
Asse::addJs('bootstrap.min.js',Yii::getPathOfAlias('webroot.web.bootstrap_300.js'));
/* @var $this Controller */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />

	<!-- blueprint CSS framework -->
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/screen.css" media="screen, projection" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/print.css" media="print" />
	<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/ie.css" media="screen, projection" />
	<![endif]-->


	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/form.css" />


	<title><?php echo CHtml::encode($this->pageTitle); ?></title>
</head>

<body>

<div class="container" id="page">

	<div id="header">
		<div id="logo"><?php echo CHtml::encode(Yii::app()->name); ?></div>
	</div><!-- header -->

    <nav class="navbar navbar-default" role="navigation">
        <div class="collapse navbar-collapse navbar-ex1-collapse">


            <?php $this->widget('application.widgets.b3menu.b3menuWidget',array(
                'items'=>array(
                    array('label'=>'Home',
                        'url'=>array('/site/index'),
                    ),
                    array('label'=>'Content',
                        'url'=>array('/site/index'),
                        'items'=>array(

                            array('label'=>'Users'),

                            array(),
                        )
                    ),


                )
            )); ?>


<!--            <form class="navbar-form navbar-left" role="search">-->
<!--                <div class="form-group">-->
<!--                    <input type="text" class="form-control" placeholder="Search">-->
<!--                </div>-->
<!--                <button type="submit" class="btn btn-default">Submit</button>-->
<!--            </form>-->


            <?php $this->widget('application.widgets.b3menu.b3menuWidget',array(
                'htmlOptions' => array('class'=>'nav navbar-nav navbar-right'),
                'items'=>array(
                    array('label'=>'Login', 'url'=>array('/user/login/login'), 'visible'=>Yii::app()->user->isGuest),
                    array('label'=>'Logout ('.Yii::app()->user->name.')', 'url'=>array('/user/login/logout'), 'visible'=>!Yii::app()->user->isGuest),
                    array('label'=>'Register', 'url'=>array('/user/register/register'), 'visible'=>Yii::app()->user->isGuest)
                )
            )); ?>

        </div>
    </nav>


    <?php if(isset($this->breadcrumbs)):?>
		<?php $this->widget('zii.widgets.CBreadcrumbs', array(
			'links'=>$this->breadcrumbs,
		)); ?><!-- breadcrumbs -->
	<?php endif?>

	<?php echo $content; ?>

	<div class="clear"></div>

	<div id="footer">
		Copyright &copy; <?php echo date('Y'); ?> by My Company.<br/>
		All Rights Reserved.<br/>
		<?php echo Yii::powered(); ?>
	</div><!-- footer -->

</div><!-- page -->

</body>
</html>
