<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_header.php')?>
Добрый день! <br/><br/>
Вы получили это письмо, поскольку Ваш адрес электронной почты был указан на сайте <?php echo  Yii::app()->name ?> как новый вместо <?php echo  $old_email ?>
<br/>
Если Вы получили это письмо по ошибке, то проигнорируйте его.<br/><br/>

Для завершения изменения адреса электронной почты пройдите по ссылке:<br/>
<a href="<?php echo $url;?>" style="color: #EE611C"><?php echo $url; ?></a>

<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>