<?php

class Cut
{
    /**
     * @static
     * @param $route
     * @param array $params
     * @param string $ampersand
     * @return void
     */
    public static function createUrl($route, $params = array(), $ampersand = '&')
    {
        return preg_replace('/^protected/', '', Yii::app()->urlManager->createUrl($route, $params, $ampersand));

    }

    /**
     *  Удаляет рекурсивно директорию
     * @static
     * @param $dir
     * @return void
     */
    public static function delDirTree($dir)
    {
        if (!file_exists($dir)) return true;
        if (!is_dir($dir) || is_link($dir)) return unlink($dir);
        foreach (scandir($dir) as $item) {
            if ($item == '.' || $item == '..') continue;
            if (!self::delDirTree($dir . "/" . $item)) {
                chmod($dir . "/" . $item, 0777);
                if (!self::delDirTree($dir . "/" . $item)) return false;
            };
        }
        return rmdir($dir);
    }

    public static function getHtmlPageTitle($only_last_elem = false, $need_slogan = false)
    {
        if (!Yii::app()->getController()->pageTitle && count(Yii::app()->getController()->breadcrumbs)) {
            $bcr = array_reverse(Yii::app()->getController()->breadcrumbs);
            Yii::app()->getController()->pageTitle = $bcr[0];
        }
        $slogan = ' [' . Yii::app()->name . ' - ' . Yii::app()->params['slogan'] . ']';

        return trim(CHtml::encode(Yii::app()->getController()->pageTitle . ($need_slogan ? $slogan : '')));
    }

    public static function makeDate($date, $format = "d MMMM yг. в HH:mm")
    {
        return Yii::app()->dateFormatter->format($format, $date);
    }

    public static function isOvertime($time, $minutes_limit = 1, $now = null)
    {


        $t = $now ? $now : date("Y-m-d H:i:s");
        //die(date("Y-m-d H:i:s"));
        return (strtotime($time . ' +' . $minutes_limit . ' minutes') < strtotime($t));
    }

    public static function setFlash($text = '', $type = 'notice')
    {
        Yii::app()->user->setFlash($type, $text);
    }

    /**
     * @static
     * @param bool $all_excl
     * @return CHtmlPurifier
     */
    public static function getPurifyObject($all_excl = false)
    {
        $purif = new CHtmlPurifier();
        if ($all_excl) {
            $purif->options = array(
                'HTML.AllowedElements' => array()
            );
        } else {
            $purif->options = array(
                'AutoFormat.Linkify' => true,
                //'AutoFormat.AutoParagraph' => true,
                'AutoFormat.RemoveEmpty' => true,
                //'HTML.MaxImgLength' => '800',
                //'CSS.MaxImgLength' => '800',
                //'Filter.YouTube' => true,
                'HTML.Nofollow' => true,
                'HTML.AllowedElements' => array('a'),

            );
        }
        return $purif;
    }

    public static function getRtfPurifyObject()
    {
        $purif = new CHtmlPurifier();

        $purif->options = array(
            'AutoFormat.Linkify' => true,
            'AutoFormat.RemoveEmpty' => true,
            'HTML.MaxImgLength' => '800',
            'CSS.MaxImgLength' => '800',
            'AutoFormat.AutoParagraph' => true,
            'HTML.Nofollow' => true,
            'HTML.AllowedElements' => array('br', 'a', 'img', 'p', 'ul', 'ol', 'span', 'li', 'i', 'b', 'strong', 'em'),
        );

        return $purif;
    }

    /**
     * @param $url
     * @return mixed
     * @throws CException
     */
    public static function file_get($url)
    {

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        //curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1');

        curl_setopt($ch, CURLOPT_URL, $url);

        $result = curl_exec($ch);

        $headers = curl_getinfo($ch);

        if (curl_errno($ch) > 0)
            throw new CException(curl_error($ch), curl_errno($ch));

        curl_close($ch);

        return $result;
    }

}
