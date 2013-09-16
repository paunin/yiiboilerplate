<?php

Asse::addCss('bootstrap.min.css',Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
Asse::addCss('bootstrap-theme.min.css',Yii::getPathOfAlias('webroot.web.bootstrap_300.css'));
Asse::addJs('jquery/jquery-1.10.2.min.js');
Asse::addJs('bootstrap.min.js',Yii::getPathOfAlias('webroot.web.bootstrap_300.js'));

/* @var $this Controller */ ?>
<?php $this->beginContent('//layouts/main'); ?>
<div id="content">
	<?php echo $content; ?>
</div><!-- content -->
<?php $this->endContent(); ?>