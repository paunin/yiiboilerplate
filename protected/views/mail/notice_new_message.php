<? if (empty($alt) || !$alt)
    require(dirname(__FILE__ ). '/_header.php')?>

<?php /** @var $message Message */
$from_user = $message->fromUser;
$to_user = $message->toUser;
?>
Пользователь <b><a href="<?=$from_user->getUrl(true)?>" style="color: #EE611C"><?=$from_user->username?></a></b>
отправил вам новое сообщение:
<blockquote style="color: #555;">
    <?= $message->text ?>
</blockquote>
<a href="<?=$from_user->getUrl(true)?>" style="color: #EE611C">Ответить на сообщение</a>
<br/><br/>
<span style="font-size: 0.8em;">Чтобы не получать подобные письма, отключите уведомление о новых сообщениях у себя на странице <a href="<?=$to_user->getUrl(true)?>" style="color: #EE611C"><?=$to_user->getUrl(true)?></a>.</span>


<? if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>