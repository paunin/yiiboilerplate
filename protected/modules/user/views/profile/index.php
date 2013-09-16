<?php
/* @var $this ProfileController */

$this->pageTitle=Yii::app()->name . ' - Current user profile';
$this->breadcrumbs=array(
    'Current user profile',
);
?>
Hello, <?php echo User::current()?> (IP = <?php echo Yii::app()->request->getUserHostAddress() ?>)<br/>

<br/><br/>
<h2>All users on site</h2>
<?php
$criteria = new CDbCriteria();
$pagination = new Pagination(User::model()->count($criteria));
$pagination->pageSize = 5;
$pagination->currentPage = Yii::app()->request->getParam('page',0);
$pagination->applyLimit($criteria);
$pagination->setResults(User::model()->findAll($criteria));

?>

<?php
    foreach($pagination->getResults() as $user):
    /** @var User $user */
    echo $user->username." ({$user->email})".'</br>';
    endforeach;
    ?>
<?php echo $pagination->renderHtml() ?>