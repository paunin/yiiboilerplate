<?php

Yii::import('application.models._base.BaseCronMail');

class CronMail extends BaseCronMail
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    /**
     * @param array $mail_to
     * @return bool
     */
    public function multiSave(array $mail_to){
        $connection=Yii::app()->db;
        $vals = array();
        foreach ($mail_to as $_mail => $_name) {

            $vals[] = "(:subject,
                        :body,
                        :body_alt,
                        ".$connection->quoteValue($_mail).",
                        ".$connection->quoteValue($_name).",
                        :from_mail,
                        :from_name)";
        }


        $_vals = implode(',',$vals);
        $sql = <<<SQL
                    INSERT INTO cron_mail
                                  (subject, body, body_alt, to_mail, to_name, from_mail,
                                   from_name)
                      VALUES
                        $_vals

SQL;

        $params = array(
            'subject' => $this->subject,
            'body' => $this->body,
            'body_alt' => $this->body_alt,
            'from_mail' => $this->from_mail,
            'from_name' => $this->from_name
        );

        $command=$connection->createCommand($sql);
        return (bool) $command->execute($params);
    }
}