<?php
class Russian
{

    /**
     * В русском языке существует три формы множественных чисел:
     * 1, 21, 31... день
     * 2, 3, 4, 22, 23, 24, 32, 33, 34... дня
     * 0, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 25, 26, 27, 28, 29, 30, 35, 36... дней
     *
     *
     * Пример:
     * <code>
     * <?php
     * $text = russian_plural(
     *       $count,
     *       array(
     *           '%n актуальное событие',
     *           '%n актуальных события',
     *           '%n актуальных событий',
     *       ),
     *       'Новых сообщений нет');
     * ?>
     * </code>
     *
     * @author ploginoff
     * @link http://ru.wikipedia.org/wiki/Gettext#.D0.9C.D0.BD.D0.BE.D0.B6.D0.B5.D1.81.D1.82.D0.B2.D0.B5.D0.BD.D0.BD.D1.8B.D0.B5_.D1.87.D0.B8.D1.81.D0.BB.D0.B0_2
     * @param integer $n     цифра
     * @param array   $forms массив строк с шаблоном %n
     * @param string  $none  шаблон для случая, когда число = 0
     * @return string
     */
    public static function russian_plural($n, array $forms = array("%n", "%n", "%n"), $none = "-")
    {
        $old_n = $n;
        $n = (int)$n;

        $plural = (((($n % 10) == 1) && (($n % 100) != 11)) ? (0)
                : ((((($n % 10) >= 2) && (($n % 10) <= 4)) && ((($n % 100) < 10) || (($n % 100) >= 20))) ? (1) : 2));

        if ($n) {

            $nn = number_format($n,0,',',' ');
            $text = str_replace('%n', $nn, $forms[$plural]);
        }
        elseif($n==0 && $old_n==$n){
            $text = $none;
        }else{
            $text =  $old_n;
        }

        return $text;
    }

    /**
     * 1970-02-22 => 41 год
     * @param  string $date timestamp
     * @return string
     */
    public static function russian_years($date)
    {
        $date = strtotime($date);

        $year_diff = date('Y') - date('Y', $date);
        $month_diff = date('m') - date('m', $date);
        $day_diff = date('d') - date('d', $date);

        if ($month_diff < 0) {
            $year_diff--;
        } elseif (($month_diff == 0) && ($day_diff < 0)) {
            $year_diff--;
        }

        if ($year_diff < 0) {
            $year_diff = 0;
        }

        return russian_plural(
            $year_diff,
            array(
                 '%n год',
                 '%n года',
                 '%n лет'),
            '-');
    }

    public static function russian_number($number, $empty = '')
    {
        $number = intval($number);

        if (!$number) {
            return $empty;
        }

        $minus = $number < 0 ? '-' : '';
        $number = abs($number);

        if ($number < 1E+3) {
            $return = $number;
        } elseif ($number < 1E+6) {
            $return = intval($number / 1E+3) . " тыс.";
        } elseif ($number < 1E+9) {
            $return = intval($number / 1E+6) . " млн.";
        } else {
            $return = intval($number / 1E+9) . " млрд.";
        }
        $return = "{$minus}{$return}";
        return $return;
    }

    /**
     * имя месяца
     *
     * @param int $month_number
     * @return string
     */
    public static function getMonthName($month_number)
    {
        $month_number = (int)$month_number;
        if ($month_number < 1 || $month_number > 12)
            return null;

        $months = array(
            '1' => 'Январь',
            '2' => 'Февраль',
            '3' => 'Март',
            '4' => 'Апрель',
            '5' => 'Май',
            '6' => 'Июнь',
            '7' => 'Июль',
            '8' => 'Август',
            '9' => 'Сентябрь',
            '10' => 'Октябрь',
            '11' => 'Ноябрь',
            '12' => 'Декабрь'
        );

        return $months[$month_number];
    }

    /**
     * Транслит с сохранением регистра
     * @param  string $string
     * @return string
     */
    public static function russian_translit($string)
    {
        $tr = array(
            'А' => 'A', 'Б' => 'B', 'В' => 'V', 'Г' => 'G', 'Д' => 'D',
            'Е' => 'E', 'Ж' => 'J', 'З' => 'Z', 'И' => 'I', 'Й' => 'Y',
            'К' => 'K', 'Л' => 'L', 'М' => 'M', 'Н' => 'N', 'О' => 'O',
            'П' => 'P', 'Р' => 'R', 'С' => 'S', 'Т' => 'T', 'У' => 'U',
            'Ф' => 'F', 'Х' => 'H', 'Ц' => 'Ts', 'Ч' => 'Ch', 'Ш' => 'Sh',
            'Щ' => 'Sch', 'Ъ' => '', 'Ы' => 'Yi', 'Ь' => '', 'Э' => 'E',
            'Ю' => 'Yu', 'Я' => 'Ya',
            'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd',
            'е' => 'e', 'ж' => 'j', 'з' => 'z', 'и' => 'i', 'й' => 'y',
            'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o',
            'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u',
            'ф' => 'f', 'х' => 'h', 'ц' => 'ts', 'ч' => 'ch', 'ш' => 'sh',
            'щ' => 'sch', 'ъ' => 'y', 'ы' => 'yi', 'ь' => '', 'э' => 'e',
            'ю' => 'yu', 'я' => 'ya',
        );

        $return = strtr($string, $tr);

//        if (function_exists('mb_convert_encoding')) {
//            // не известные символы заменять на знак вопроса
//            $return = mb_convert_encoding($return, 'ASCII', 'UTF-8');
//        }

        return $return;
    }

    public static function russian_slugify($text)
    {
        if (preg_match('/[^A-Za-z0-9_\-]/', $text)) {
            $text = strtr($text, array('/' => '_', ' ' => '_'));
            $text = russian_translit($text);
            $text = strtolower($text);
            $text = preg_replace('/[^A-Za-z0-9_\-]/', '', $text);
        }

        $text = preg_replace('~[^\\pL\d]+~u', '-', $text);
        $text = trim($text, '-');
        $text = strtolower($text);
        $text = preg_replace('~[^-\w]+~', '', $text);

        if (empty($text)) {
            return 'n-a';
        }

        return $text;
    }

    public static function russian_days_ago_in_words($date)
    {
        $date_tmp = array('today' => new DateTime(date('d.m.Y')),
                          'yesterday' => new DateTime(date('d.m.Y', strtotime("-1 day"))),
                          'before_yesterday' => new DateTime(date('d.m.Y', strtotime("-2 day"))));
        $date = new DateTime(date('d.m.Y', $date));
        if ($date == $date_tmp['today']) {
            return "cегодня";
        }
        else if ($date == $date_tmp['yesterday']) {
            return "вчера";
        }
        else if ($date == $date_tmp['before_yesterday']) {
            return "позавчера";
        }
        else {
            return $date->format('m.d.Y');
        }
    }

    /**
     * Хелпер возвращающий сколько прошло времени с текущего момента
     * до переданного.
     *
     * <code>
     * // разница между $date2 и $date1
     * russian_time_ago_in_words(date1, $date2);
     *
     * // разница между текущей датой и date1
     * russian_time_ago_in_words(date1);
     * </code>
     *
     * @param $from_time
     * @param integer $to_time
     * @param boolean $include_seconds
     * @return string
     */

    public static function russian_time_ago_in_words ($from_time, $to_time = null, $include_seconds = false, $if_now_text = 'менее минуты назад', $vk_style = true) {
      //date_default_timezone_set('Asia/Krasnoyarsk');
      $to_time = $to_time ? $to_time: time();
      if (is_string($from_time))
        $from_time = strtotime($from_time);
      $distance_in_minutes = floor(abs($to_time - $from_time) / 60);
      $distance_in_seconds = floor(abs($to_time - $from_time));

      $result = array('value'       => null,
                      'pural_forms' => array());

      $plural_forms = array('seconds' => array('менее %n секунды назад',
                                               'менее %n секунд назад',
                                               'менее %n секунд назад',),
                            'minutes' => array('%n минуту назад',
                                               '%n минуты назад',
                                               '%n минут назад',),
                            'hours'   => array('%n час назад',
                                               '%n часа назад',
                                               '%n часов назад',),
                            'days'    => array('%n день назад',
                                               '%n дня назад',
                                               '%n дней назад',),
                            'months'  => array('%n месяц назад',
                                               '%n месяца назад',
                                               '%n месяцев назад',),
                            'years'   => array('%n год назад',
                                               '%n года назад',
                                               '%n лет назад',),
                            );

      $parameters = array();

      if ($distance_in_minutes <= 1)
      {
        if (!$include_seconds)
        {
          if($distance_in_minutes == 0)
              return $if_now_text;
          $result = $distance_in_minutes == 0 ? array('value'        => $if_now_text,
                                                      'plural_forms' => array())
                                              : array('value' => 1,
                                                      'plural_forms' => $plural_forms['minutes']);
        }
        else
        {

          if ($distance_in_seconds <= 5)
          {
            $result = array('value' => 5,
                            'plural_forms' => $plural_forms['seconds']);
          }
          else if ($distance_in_seconds >= 6 && $distance_in_seconds <= 10)
          {
            $result = array('value' => 10,
                            'plural_forms' => $plural_forms['seconds']);
          }
          else if ($distance_in_seconds >= 11 && $distance_in_seconds <= 20)
          {
            $result = array('value' => 20,
                            'plural_forms' => $plural_forms['seconds']);
          }
          else if ($distance_in_seconds >= 21 && $distance_in_seconds <= 40)
          {
            $result = array('value' => 30,
                            'plural_forms' => $plural_forms['seconds']);
          }
          else if ($distance_in_seconds >= 41 && $distance_in_seconds <= 59)
          {
            $result = array('value' => 'менее минуты назад',
                            'plural_forms' => $plural_forms['seconds']);
          }
          else
          {
            $result = array('value' => 1,
                            'plural_forms' => $plural_forms['minutes']);
          }
        }
      }
      else if ($distance_in_minutes >= 2 && $distance_in_minutes <= 44)
      {
        $result = array('value' => $distance_in_minutes,
                        'plural_forms' => $plural_forms['minutes']);
      }
      else if ($distance_in_minutes >= 45 && $distance_in_minutes <= 89)
      {
        $result = array('value' => 1,
                        'plural_forms' => $plural_forms['hours']);
      }
      else if ($distance_in_minutes >= 90 && $distance_in_minutes <= 1439)
      {
        $result = array('value' => round($distance_in_minutes / 60),
                        'plural_forms' => $plural_forms['hours']);
      }
//      else if($vk_style && $distance_in_minutes > ){
//
//      }
      else if ($distance_in_minutes >= 1440 && $distance_in_minutes <= 2879)
      {
        $result = array('value' => 1,
                        'plural_forms' => $plural_forms['days']);
      }
      else if ($distance_in_minutes >= 2880 && $distance_in_minutes <= 43199)
      {
        $result = array('value' => round($distance_in_minutes / 1440),
                        'plural_forms' => $plural_forms['days']);
      }
      else if ($distance_in_minutes >= 43200 && $distance_in_minutes <= 86399)
      {
        $result = array('value' => 1,
                        'plural_forms' => $plural_forms['months']);
      }
      else if ($distance_in_minutes >= 86400 && $distance_in_minutes <= 525959)
      {
        $result = array('value' => round($distance_in_minutes / 43200),
                        'plural_forms' => $plural_forms['months']);
      }
      else if ($distance_in_minutes >= 525960 && $distance_in_minutes <= 1051919)
      {
        $result = array('value' => 1,
                        'plural_forms' => $plural_forms['years']);
      }
      else
      {
        $result = array('value' => floor($distance_in_minutes / 525960),
                        'plural_forms' => $plural_forms['years']);
      }
      return self::russian_plural($result['value'], $result['plural_forms']);
    }

}
