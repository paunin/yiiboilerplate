<style>
    .form-add-event-title{
        font-size: 20px;
        margin-right: 10px;
    }
    input.date{
        width: 100px;
    }
    input.time{
        width: 65px;
    }
    input.note{
        width: 320px;
    }
</style>
<div>
    <img src="<?php
    echo Img::getSizedPath(
        Yii::getPathOfAlias('webroot').'/images/baby-boy.png',
        50,
        50
    );
    ?>">

    <form class="form-inline" role="form" style="float: right; margin-top: 10px">
        <div class="form-group form-add-event-title">
            Add event
        </div>
        <div class="form-group">
            <select class="form-control">
                <option style="background-color: #fff">Sleep</option>
                <option>Eat</option>
                <option>Bath</option>
                <option>Walk</option>
            </select>
        </div>
        <div class="form-group">
            <input type="text" class="form-control time" placeholder="<?php echo Yii::t('app','Start')?>">
        </div>
        <div class="form-group">
            <input type="text" class="form-control time" placeholder="<?php echo Yii::t('app','Finish')?>">
        </div>

        <div class="form-group">
            <input type="text" class="form-control date bfh-datepicker" placeholder="<?php echo Yii::t('app','Date')?>">
        </div>
        <div class="form-group">
            <input type="text" class="form-control note" placeholder="<?php echo Yii::t('app','Note')?>">
        </div>
        <button type="submit" class="btn btn-default">Add</button>
    </form>

    <hr/>

    <div class="chart-element">
        <div class="chart-element-date">2013-12-12</div>
        <ul class="chart-element-bar">

        </ul>
    </div>

</div>