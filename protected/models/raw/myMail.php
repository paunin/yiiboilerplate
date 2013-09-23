<?php
/**
 * Class myMail
 *
 * Requires:
 *      Params for
 *          Yii::app()->params['robotEmail']
 *          Yii::app()->params['robotEmailName']
 *
 *      Table Smtp: CREATE TABLE smtp
 *                               (
 *                                  id serial NOT NULL,
 *                                  host character varying NOT NULL,
 *                                  username character varying NOT NULL,
 *                                  "password" character varying NOT NULL,
 *                                  port character varying,
 *                                  encryption character varying,
 *                                  timeout character varying,
 *                                  "extensionHandlers" character varying,
 *                                  using_count integer NOT NULL DEFAULT 0,
 *                                  banned integer NOT NULL DEFAULT 0,
 *                                  CONSTRAINT smtp_pkey PRIMARY KEY (id)
 *                                )
 *
 */

class myMail
{

    /**
     * @param $mail_to
     * @param $subject
     * @param $template
     * @param $data
     * @return bool
     * @throws CException
     * @throws Exception
     */
    public static function smtpSend($mail_to, $subject, $template, $data)
    {

        $cr = new CDbCriteria();
        $cr->addCondition('banned < 100');
        $cr->order = 'banned+using_count';
        /** @var $smtp Smtp */
        $smtp = Smtp::model()->find($cr);

        if (!$smtp)
            throw new CException('No smtps');

        try {
            if (self::send($mail_to, $subject, $template, $data, false, null, $smtp->asArray())) {
                $smtp->using_count += 1;
                $smtp->save();
                return true;
            } else {
                $smtp->banned += 1;
                $smtp->save();
                return false;
            }
        } catch (Exception $e) {
            $smtp->banned += 1;
            $smtp->save();
            throw $e;
        }

    }

    /**
     * @param $mail_to
     * @param $subject
     * @param $template
     * @param $data
     * @param bool $by_cron
     * @param null $sender
     * @param null $smtp
     * @return bool
     */
    public static function send($mail_to, $subject, $template, $data, $by_cron = false, $sender = null, $smtp = null)
    {

        $body = self::getBody($template, $data);

        try {
            $body_alt = self::getBody($template, $data, true);
        } catch (Exception $e) {
            $body_alt = null;
        }

        if (!is_array($mail_to)) {
            $mail_to = array($mail_to => $mail_to);
        }
        //$mail_to = array('qwe@qw.qw'=>'q','qwea2qwqw@qw.qs'=>'q1');
        if ($by_cron) {
            $cronMail = new CronMail();
            $cronMail->subject = $subject;
            $cronMail->body = $body;
            $cronMail->body_alt = $body_alt;
            $cronMail->from_mail = Yii::app()->params['robotEmail'];
            $cronMail->from_name = Yii::app()->params['robotEmailName'];
            return $cronMail->multiSave($mail_to);
        } else {
            return self::nativeSend($mail_to, $subject, $body, $body_alt, array(Yii::app()->params['robotEmail'] => Yii::app()->params['robotEmailName']), $smtp);
        }
    }

    /**
     * @param $mail_to
     * @param $subject
     * @param $body
     * @param null $body_alt
     * @param null $senders
     * @param null $smtp
     * @return bool
     */
    private static function nativeSend($mail_to, $subject, $body, $body_alt = null, $senders = null, $smtp = null)
    {
        /** @var $message Swift_Message */
        $message = new YiiMailMessage;
        $body = self::embedAllImages($message,$body);

        $message->setBody($body, 'text/html');
        $message->addPart($body_alt, 'text/plain');
        $message->subject = $subject;

        $sm = Yii::app()->mail;
        $message->from = $senders;


        if ($smtp !== null) {
            $message->from = array($smtp['username'] => $smtp['username']);
            $sm->transportOptions = $smtp;
            $sm->transportType = 'smtp';
        }
        $res = true;
        foreach ($mail_to as $_mail => $_name) {
            $message->to = array($_mail => $_name);
            if (!$sm->send($message))
                $res = false;
            else
                ;
        }
        return $res;
    }

    /**
     * Embed all images from Yii::getPathOfAlias('application.views.mail.images') to &$message and replace `cid`s in $body
     *
     * @param $message
     * @param $body
     * @return mixed
     */
    private static function embedAllImages(&$message,$body){
        $img_dir = Yii::getPathOfAlias('application.views.mail.images');

        $files = array_diff(scandir($img_dir), array('..', '.'));
        $search = array();
        $replace = array();

        foreach($files as $file){
            $cid = $message->embed(Swift_Image::fromPath($img_dir.'/'.$file));
            array_push($search,"%cid_{$file}%");
            array_push($replace,$cid);
        }
        $body = str_replace($search,$replace,$body);
        die($body);
        return $body;
    }


    /**
     * @static
     * @param $template
     * @param array $data
     * @param bool $alt
     * @return mixed
     */
    private static function getBody($template, array $data = array(), $alt = false)
    {

        if (isset(Yii::app()->controller))
            $controller = Yii::app()->controller;
        else
            $controller = new CController('YiiMail');

        $viewPath = Yii::getPathOfAlias(Yii::app()->mail->viewPath . '.' . $template) . '.php';

        $body = $controller->renderInternal($viewPath, array_merge($data, array('alt' => $alt)), true);

        if ($alt) {
            $p = new CHtmlPurifier();
            $p->options = array('HTML.Allowed' => '');
            $body = $p->purify($body);
        }

        return $body;
    }

    /**
     * @param int $limit
     */
    public static function cronSend($limit = 5)
    {
        $criteria = new CDbCriteria();
        $criteria->addCondition('is_sent = false');
        $criteria->limit = $limit;
        $criteria->order = "id";
        $mails = CronMail::model()->findAll($criteria);
        if (count($mails)) {
            foreach ($mails as $mail) {
                /** @var CronMail $mail */

                if (self::nativeSend(
                    array($mail->to_mail => $mail->to_name),
                    $mail->subject,
                    $mail->body,
                    $mail->body_alt,
                    array($mail->from_mail => $mail->from_name)
                )
                ) {
                    $mail->is_sent = 1;
                    $mail->save();
                }
            }
        }
    }
}