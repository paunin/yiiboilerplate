<?php
class DbWorkerCommand extends CConsoleCommand
{

    /** @var $db CDbConnection */
    private $db = null;
    public function init(){
        $this->db = Yii::app()->db;
    }

    public function actionLoad($path=null){

        if(!$path)
            $path = dirname(__FILE__).'/../tests/fixtures/dbinit.sql';

        $pdd = Yii::app()->params['pgsqlDb'];
        $pdu = Yii::app()->params['pgsqlUser'];
        $pdp = Yii::app()->params['pgsqlPassword'];
        $command = "set PGPASSWORD=$pdp && psql";
        if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            $command = 'psql';
        }

        if($pdu =='postgres')
            die('Your database can\'t be used by postgres');
        //$this->db->createCommand("DROP OWNED BY $pdu CASCADE")->execute();
        echo "drop...\n";

        
        `$command -h localhost -U $pdu -c"DROP OWNED BY $pdu CASCADE;"`;
        echo "load...\n";

        `$command -h localhost -U $pdu $pdd < $path`;
        echo 'ok'."\n";
    }

    public function actionSave($path = null){
        if(!$path)
            $path = dirname(__FILE__).'/../tests/fixtures/dbinit.sql';
        $pdd = Yii::app()->params['pgsqlDb'];
        $pdu = Yii::app()->params['pgsqlUser'];
        $pdp = Yii::app()->params['pgsqlPassword'];
        $command = "set PGPASSWORD=$pdp && pg_dump";

        `$command -h localhost -U $pdu -O -x $pdd > $path`;
        echo 'ok'."\n";
    }
}
