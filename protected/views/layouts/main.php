<?php
Asse::addCss('screen.css',null,false,'screen, projection');
Asse::addCss('print.css',null,false,'print');
Asse::addCss('main.css');
Asse::addCss('form.css');



Asse::addCss('bootstrap.min.css', Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
Asse::addCss('bootstrap-theme.min.css', Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
//Asse::addJs('jquery/jquery-1.10.2.js');
//Asse::addJs('jquery/jquery.cookie.js');

Yii::app()->getClientScript()->registerCoreScript('jquery');

Asse::addJs('bootstrap.min.js', Yii::getPathOfAlias('webroot.web.bootstrap_300.js'));

/* @var $this Controller */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="language" content="en"/>
    <link rel="shortcut icon" href="/favicon.ico" />


    <!--[if lt IE 8]>
    <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/ie.css" media="screen, projection"/>
    <![endif]-->

    <title><?php echo CHtml::encode($this->pageTitle); ?></title>
</head>

<body>
<div class="container" id="page">

    <div id="header">
        <div id="logo"><a href="/" class="logo"><?php echo CHtml::encode(Yii::app()->name); ?></a></div>
    </div>
    <!-- header -->

    <nav class="navbar navbar-default " role="navigation">
<!--        <div class="navbar-header">-->
<!--            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">-->
<!--                <span class="icon-bar"></span>-->
<!--                <span class="icon-bar"></span>-->
<!--                <span class="icon-bar"></span>-->
<!--            </button>-->
<!--            <a class="navbar-brand" href="#">--><?php //echo Yii::app()->name ?><!--</a>-->
<!--        </div>-->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <?php $this->widget('application.widgets.b3menu.b3menuWidget', array(
                'items' => array(
                    array('label' => 'Home',
                        'url' => array('/site/index'),
                    ),
                    array('label' => 'Content',
                        'url' => array('/site/index'),
                        'visible' => Yii::app()->user->checkAccess('admin'),
                        'items' => array(
                            //array('label' => 'Users'),
                            array('label' => 'Users', 'url' => array('/admin/user')),
                            array('label' => 'Content', 'url' => array('/admin/content')),
                            //array(),
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


            <?php $this->widget('application.widgets.b3menu.b3menuWidget', array(
                'htmlOptions' => array('class' => 'nav navbar-nav navbar-right'),
                'items' => array(
                    array('label' => Yii::t('app','Login'), 'url' => array('/user/login/login'), 'visible' => Yii::app()->user->isGuest),
                    array('label' => Yii::t('app','Register'), 'url' => array('/user/register/register'), 'visible' => Yii::app()->user->isGuest),

                    array(
                        'label' => Yii::app()->user->name,
                        'visible' => !Yii::app()->user->isGuest,
                        'items' => array(
                            array('label' => Yii::t('app','Profile'), 'url' => array('/user/profile/index')),
                            array('label' => Yii::t('app','Logout'), 'url' => array('/user/login/logout')),
                            array(),
                            array('label' => Yii::t('app','Change email'), 'url' => array('/user/profile/changemail')),
//                            array('label' => 'Changed email verify', 'url' => array('/user/profile/endchangemail')),
//                            array(),
                            array('label' => Yii::t('app','Changed username'), 'url' => array('/user/profile/changeusername')),
                            array('label' => Yii::t('app','Changed password'), 'url' => array('/user/profile/changepassword')),
                        )

                    )

                )
            )); ?>

        </div>
    </nav>

    <?php if (isset($this->breadcrumbs)): ?>
        <?php $this->widget('zii.widgets.CBreadcrumbs', array(
            'tagName'=>'ol',
            'homeLink'=>'<li><a href="'.Yii::app()->homeUrl.'">Home</a></li>',
            'htmlOptions'=>array('class'=>'breadcrumb'),
            'activeLinkTemplate'=>'<li><a href="{url}">{label}</a></li>',
            'inactiveLinkTemplate'=>'<li>{label}</li>',
            'separator'=>'',
			'links'=>$this->breadcrumbs,
		)); ?>
    <?php endif ?>
    <?php
    if(!empty($this->breadcrumbs) && count($this->breadcrumbs)>0):?>
        <h1><?php echo array_pop($this->breadcrumbs); ?></h1>
    <?php endif; ?>
    <?php
    foreach (Yii::app()->user->getFlashes() as $key => $message) {
        if($key=='error') //bootstrap 3
            $key = 'danger';
        elseif($key=='notice')
            $key = 'warning';
        echo '<div class="alert alert-' . ($key=='error'?'danger':$key) . '">' . $message . "</div>\n";
    }
    ?>


    <?php echo $content; ?>

    <div class="clear"></div>

    <div id="footer">
        <?php echo CHtml::encode(Yii::app()->params['slogan']) ?> &copy; <?php echo CHtml::encode(Yii::app()->name)?>
    </div>
    <!-- footer -->

</div>
<!-- page -->

</body>
</html>
