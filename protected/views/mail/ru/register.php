<?php if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_header.php')?>

Добрый день! <br/><br/>
Вы получили это письмо, поскольку Ваш адрес электронной почты был указан при регистрации на сайте <?php echo Yii::app()->name ?>
<br/>
Если Вы получили это письмо по ошибке, то проигнорируйте его.<br/><br/>

Для завершения регистрации пройдите по ссылке:<br/>
<a href="<?php echo $url;?>" style="color: #EE611C"><?php echo $url; ?></a>

<?php if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>