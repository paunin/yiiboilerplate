<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_header.php')?>
    <?php echo Yii::t('email','Hello!');?> <br/><br/>

    <?php echo Yii::t('email','To complete <b>email change</b> process click this link');?>
    <?php if(!empty($old_email)): ?>(<?php echo Yii::t('email','old email');?> <?php echo  $old_email ?>) <?php endif; ?>:<br/>
    <a href="<?php echo $url; ?>"><?php echo $url; ?></a>
    <br/>
    <br/>
    <?php echo Yii::t('email','Please ignore this message if you not sure in future actions.');?><br/><br/>

<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>