<?php
$cid_bg = '%cid_bg%';
$cid_logo = '%cid_logo%';
$site_url = Yii::app()->params['site_url']
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body bgcolor="#fafafa" background="<?php echo $cid_bg?>"
      style="padding:0; margin:0; background-color:#fafafa; background-image:url('<?php echo  $cid_bg ?>');">
<table bgcolor="#fafafa" background="<?php echo $cid_bg?>" width="100%">
    <tr>
        <td width="100%">
            <div style="max-width: 1024px; margin: 20px 20px 0; padding-left: 50px;">
                <a href="<?php echo $site_url?>" title="<?php echo Yii::app()->name?>">
                    <img src="<?php echo $cid_logo?>" alt="<?php echo Yii::app()->params['site_url']?>">
                </a>
            </div>
            <div style="background: none repeat scroll 0 0 white;
                    border: 1px solid #e8e4e4;
                    box-shadow: 0 0 10px #AAAAAA;
                    max-width: 1024px;
                    margin: 20px 40px;
                    padding: 30px 20px 70px;">

