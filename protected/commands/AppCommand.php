<?php
class AppCommand extends CConsoleCommand
{
    public function actionCC()
    {
        Yii:: app()->cache->flush();
    }
}
