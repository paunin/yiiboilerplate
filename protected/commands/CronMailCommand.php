<?php
class CronMailCommand extends CConsoleCommand
{
    public function actionSend($limit = 5) {
        myMail::cronSend($limit);
    }
}

