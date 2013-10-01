<?php
class DbWorkerCommand extends CConsoleCommand
{
    private $pdd, $pdu, $pdp, $pdh;

    /** @var $db CDbConnection */
    private $db = null;
    public function init(){
        $this->pdd = Yii::app()->params['sqlDb'];
        $this->pdu = Yii::app()->params['sqlUser'];
        $this->pdp = Yii::app()->params['sqlPassword'];
        $this->pdh = Yii::app()->params['sqlHost'];
        $this->db = Yii::app()->db;
    }

    public function actionLoad($path=null){

        if(!$path)
            $path = $this->getDefaultFile();

        $command = $this->getPreCommand()." psql";
        if($this->pdu =='postgres')
            die('Your database can\'t be used by postgres');


        echo "droping...";
        `$command -h {$this->pdh} -U {$this->pdu} -c"DROP OWNED BY {$this->pdu} CASCADE;"`;
        echo "done\n";

        echo "loading...";
        `$command -h {$this->pdh} -U {$this->pdu} {$this->pdd} < $path`;
        echo "done\n";

        echo 'ok'."\n";
    }

    public function actionSave($path = null){
        if(!$path)
            $path = $this->getDefaultFile();

        $command = $this->getPreCommand()."pg_dump --encoding=UTF8";

        `$command -h {$this->pdh} -U {$this->pdu} -O -x {$this->pdd} > $path`;
        echo 'ok'."\n";
    }

    private function getDefaultFile(){
        return dirname(__FILE__).'/../tests/fixtures/dbinit.sql';
    }

    private function getPreCommand()
    {
        if (empty($this->pdp))
            return '';

        if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            $command = "set PGPASSWORD={$this->pdp} ";
            `$command`;
            return '';
        } else {
            $command = "env PGPASSWORD={$this->pdp} ";
        }
        return $command;
    }
}
