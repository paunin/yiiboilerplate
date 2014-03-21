<?php
class DbWorkerCommand extends CConsoleCommand
{
    private $pdd, $pdu, $pdp, $pdhost, $pdport;

    /** @var $db CDbConnection */
    private $db = null;
    public function init(){
        $this->db = Yii::app()->db;

        $db_connection_string = $this->db->connectionString;

        if (strpos($db_connection_string, 'pgsql:') !== 0) {
            throw new CException('Only postgres string is supported. Like this: "pgsql:host=localhost;port=5432;dbname=mydb"');
        }

        $db_connection_string = substr($db_connection_string, strlen('pgsql:'));
        foreach (explode(';', $db_connection_string) as $param_string) {
            $param_value = explode('=', $param_string);
            $db_connection_params[$param_value[0]] = $param_value[1];
        }

        $this->pdd = isset($db_connection_params['dbname'])?$db_connection_params['dbname']:'';;
        $this->pdu = $this->db->username;
        $this->pdp = $this->db->password;
        $this->pdhost = isset($db_connection_params['host'])?$db_connection_params['host']:'';
        $this->pdport = isset($db_connection_params['port'])?$db_connection_params['port']:'';
    }

    public function actionLoad($path=null){

        if(!$path)
            $path = $this->getDefaultFile();

        $command = $this->getPreCommand()." psql";
        if($this->pdu =='postgres')
            die('Your database can\'t be used by postgres');

        $add_port = "";
        if(!empty($this->pdport)) {
            $add_port = "-p {$this->pdport}";
        }

        echo "droping...";
        `$command -h {$this->pdhost} $add_port -U {$this->pdu} -c"DROP OWNED BY {$this->pdu} CASCADE;"`;
        echo "done\n";

        echo "loading...";
        `$command -h {$this->pdhost} $add_port -U {$this->pdu} {$this->pdd} < $path`;
        echo "done\n";

        echo "ok\n";
    }

    public function actionSave($path = null){
        if(!$path)
            $path = $this->getDefaultFile();

        $command = $this->getPreCommand()."pg_dump --encoding=UTF8";

        $add_port = "";
        if(!empty($this->pdport)) {
            $add_port = "-p {$this->pdport}";
        }

        `$command -h {$this->pdhost} $add_port -U {$this->pdu} -O -x {$this->pdd} > $path`;
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
