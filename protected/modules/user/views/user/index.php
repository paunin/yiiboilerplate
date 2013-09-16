Current user roles:<br/>
<?php
    echo Yii::app()->user->checkAccess('user')?'User<br/>':'';
    echo Yii::app()->user->checkAccess('admin')?'Admin<br/>':'';
