<?php
/* @var $this SiteController */

$this->pageTitle = Yii::app()->name;
?>

<h1>Welcome to <i><?php echo CHtml::encode(Yii::app()->name); ?></i></h1>

<h1>Examples:</h1>

<h2>All users with pagination</h2>
<?php
$criteria = new CDbCriteria();
$pagination = new Pagination(User::model()->count($criteria));
$pagination->pageSize = 5;
$pagination->currentPage = Yii::app()->request->getParam('page', 0);
$pagination->applyLimit($criteria);
$pagination->setResults(User::model()->findAll($criteria));

foreach ($pagination->getResults() as $user):
    /** @var User $user */
    echo $user->username . " ({$user->email})" . '</br>';
endforeach;
?>
<?php echo $pagination->renderHtml() ?>

<h2>Event:</h2>
<?php
Event::attacheHandlers($this);
$this->onSomething(new CEvent());
?>


<h2>Cache:</h2>
<?php
$val = rand(1, 99999);
echo "Real value = $val<br/>";
?>

<?php if (Cache::begin('ckey')):
    echo "Cached value = $val<br/> (don't foget about dev config and dummy cache)";
    Cache::endCache();
endif;?>
<h2>TinyMce:</h2>
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/js/tinymce4jq/tinymce.min.js"></script>
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/js/tinymce4jq/jquery.tinymce.min.js"></script>
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/js/tinymce4jq/big_tiny_init_jq.js"></script>

<textarea class="big_tiny" ></textarea>

<h2>Eauth:</h2>
<?php
$this->widget('ext.eauth.EAuthWidget', array('action' => '/user/login/login'));
?>