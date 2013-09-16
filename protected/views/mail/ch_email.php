<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_header.php')?>
    Hello! <br/><br/>

    To complete <b>email change</b> process click this link (old email <?php echo  $old_email ?>):<br/>
    <a href="<?php echo $url; ?>" style="color: #EE611C"><?php echo $url; ?></a>
    <br/>
    <br/>
    Please ignore this message if you not sure in future actions.<br/><br/>

<?php  if (empty($alt) || !$alt)
    require(dirname(__FILE__) . '/_footer.php')?>