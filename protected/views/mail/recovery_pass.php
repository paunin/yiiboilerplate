<?php  if(empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_header.php')?>
    <?php echo Yii::t('email', 'Hello!'); ?> <br/><br/>

    <?php echo Yii::t('email','To complete <b>password recovery</b> process click this link:');?><br/>
    <a href="<?php echo $url; ?>"><?php echo $url; ?></a>
    <br/>
    <br/>
    <?php echo Yii::t('email','Please ignore this message if you not sure in future actions.');?><br/><br/>

<?php  if(empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>