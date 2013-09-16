<?php
if (!defined('SF_AUTO_LINK_RE'))
{
  define('SF_AUTO_LINK_RE', '~
    (                       # leading text
      <\w+.*?>|             #   leading HTML tag, or
      [^=!:\'"/]|           #   leading punctuation, or
      ^                     #   beginning of line
    )
    (
      (?:https?://)|        # protocol spec, or
      (?:www\.)             # www.*
    )
    (
      [-\w]+                   # subdomain or domain
      (?:\.[-\w]+)*            # remaining subdomains or domain
      (?::\d+)?                # port
      (?:/(?:(?:[\~\w\+%-]|(?:[,.;:][^\s$]))+)?)* # path
      (?:\?[\w\+%&=.;-]+)?     # query string
      (?:\#[\w\-/\?!=]*)?        # trailing anchor
    )
    ([[:punct:]]|\s|<|$)    # trailing text
   ~x');
}

class Text
{
    /**
     * use_helper('TextExt');
     *
     * Дополнительные функции для текста
     */

    public static function truncate_a($text, $length = 80)
    {
        $text = trim($text);

        $truncate = truncate_text($text, $length, '&hellip;', true);

        if ($text != $truncate) {
            $text = htmlentities($text, ENT_COMPAT, 'UTF-8');
            $return = "<a href=\"#\" onclick=\"return false;\" title=\"$text\">$truncate</a>";
        } else {
            $return = $text;
        }

        return $return;
    }

    /**
     * @static
     * @param $text
     * @param int $length
     * @param bool $nl2br
     * @param bool $purify
     * @return string
     */
    public static function truncate_fold($text, $length = 500, $need_hide = true, $purify_trunc = true, $purify_text= false, $nl2br_text = true, $nl2br_trunc = true)
    {
        $text = trim($text);
        if($purify_text)
            $text = Cut::getPurifyObject()->purify($text);
        $truncate = self::truncate_text($text, $length, '…', true);

        if ($nl2br_text) {
            $text = self::goodNl2br($text);
        }
        if ($nl2br_trunc) {
            $truncate = self::goodNl2br($truncate);
        }

        if ($text != $truncate) {
            if($purify_trunc)
                $truncate = Cut::getPurifyObject()->purify($truncate);

            $return =
                    "<span class=\"truncate\">" .
                        "<span class=\"truncate_fold_truncate\">\n$truncate\n</span>" .
                        "<a class=\"truncate_fold_more\" href=\"#\" onclick=\"return truncate_fold_more($(this));\">показать полностью&nbsp;&rarr;&nbsp;</a>" .
                        "<span class=\"truncate_fold_text\" style=\"display: none\">\n$text\n</span>" .
                        ($need_hide?"<a class=\"truncate_fold_hide\" href=\"#\" style=\"display: none\" onclick=\"return truncate_fold_hide($(this));\">&larr;&nbsp;показать кратко</a>":'').
                    "</span>";
        } else {
            $return = $text;
        }

        return $return;
    }

    public static function goodNl2br($text){
        return self::brLimit(nl2br($text));
    }


    public static function brLimit($text,$limit=2){
        return preg_replace('/(<br[^>]*>)(?:\s*\1)+/',str_repeat('$1',$limit),$text);
    }
    /**
     * $params = array('delete', 'save', 'cancel', array('name'=>'NAME', 'value'=>'VALUE'));
     */
    public static function form_buttons(array $params = array('delete', 'save', 'cancel'))
    {

        //
        // Warning: в IE6 <button работает некоректно
        //

        $btns = '<div class="buttons">';

        foreach ($params as $param) {

            if ($param == 'save') {
                $btns .= '<input type="submit" class="btn" value="Сохранить" name="Save" />';
            }

            if ($param == 'cancel') {
                $btns .= '<input type="submit" class="btn" value="Отменить" name="Cancel" />';
            }

            if ($param == 'delete') {
                $btns .= '<input type="submit" class="btn btn-del" value="Удалить" name="Delete" />';
            }

            if (is_array($param)) {
                $btns .= @ "<input type=\"submit\" class=\"btn {$param['class']}\" " .
                           "value=\"{$param['value']}\" name=\"{$param['name']}\" />";
            }
        }

        $btns .= '</div>';

        return $btns;
    }


    /**
     * ucfirst UTF-8 aware public static function
     *
     * @param string $string
     * @return string
     * @see http://www.php.net/manual/en/public static function.ucfirst.php#87133
     */
    public static function mb_ucfirst($string, $e = 'utf-8')
    {
        if (empty($string)) {
            return '';
        }
        if (function_exists('mb_strtoupper') && function_exists('mb_substr') && !empty($string)) {
            $string = mb_strtolower($string, $e);
            $upper = mb_strtoupper($string, $e);
            preg_match('#(.)#us', $upper, $matches);
            $string = $matches[1] . mb_substr($string, 1, mb_strlen($string, $e), $e);
        } else {
            $string = ucfirst($string);
        }
        return $string;
    }


    /**
     * Скрыть для поисковиков внешние ссылки (SEO)
     * default - SERVER_NAME
     *
     * @param string $text
     * @param string|array $disable_nofollow
     */

    public static function text_nofollow($text, $disable_nofollow = null)
    {
        if (is_null($disable_nofollow)) {
            if (isset($_SERVER['SERVER_NAME'])) {
                $disable_nofollow = $_SERVER['SERVER_NAME'];
            }
        }

        if (is_string($disable_nofollow)) {
            $disable_nofollow = array($disable_nofollow);
        }

        preg_match_all('#<a[^>]+(href=["\']http.*?["\'])#', $text, $links);

        if (empty($links[1])) {
            return $text;
        }

        // href="http://versia.ru/articles/2011/apr/11/vybory_po_odnomandatnym_okrugam"
        foreach ($links[1] as $link) {
            foreach ($disable_nofollow as $domen) {
                if (stripos($link, $domen) !== FALSE) {
                    continue 2;
                }
            }
            $text = str_replace($link, 'rel="nofollow" ' . $link, $text);
        }

        return $text;
    }

    
/**
 * Truncates +text+ to the length of +length+ and replaces the last three characters with the +truncate_string+
 * if the +text+ is longer than +length+.
 */
public static function truncate_text($text, $length = 30, $truncate_string = '...', $truncate_lastspace = false)
{
  if ($text == '')
  {
    return '';
  }

  $mbstring = extension_loaded('mbstring');
  if($mbstring)
  {
   $old_encoding = mb_internal_encoding();
   @mb_internal_encoding(mb_detect_encoding($text));
  }
  $strlen = ($mbstring) ? 'mb_strlen' : 'strlen';
  $substr = ($mbstring) ? 'mb_substr' : 'substr';

  if ($strlen($text) > $length)
  {
    $truncate_text = $substr($text, 0, $length - $strlen($truncate_string));
    if ($truncate_lastspace)
    {
      $truncate_text = preg_replace('/\s+?(\S+)?$/', '', $truncate_text);
    }
    $text = $truncate_text.$truncate_string;
  }

  if($mbstring)
  {
   @mb_internal_encoding($old_encoding);
  }

  return $text;
}

/**
 * Highlights the +phrase+ where it is found in the +text+ by surrounding it like
 * <strong class="highlight">I'm a highlight phrase</strong>. The highlighter can be specialized by
 * passing +highlighter+ as single-quoted string with \1 where the phrase is supposed to be inserted.
 * N.B.: The +phrase+ is sanitized to include only letters, digits, and spaces before use.
 *
 * @param string $text subject input to preg_replace.
 * @param string $phrase string or array of words to highlight
 * @param string $highlighter regex replacement input to preg_replace.
 *
 * @return string
 */
public static function highlight_text($text, $phrase, $highlighter = '<strong class="highlight">\\1</strong>')
{
  if (empty($text))
  {
    return '';
  }

  if (empty($phrase))
  {
    return $text;
  }

  if (is_array($phrase) or ($phrase instanceof sfOutputEscaperArrayDecorator))
  {
    foreach ($phrase as $word)
    {
      $pattern[] = '/('.preg_quote($word, '/').')/i';
      $replacement[] = $highlighter;
    }
  }
  else
  {
    $pattern = '/('.preg_quote($phrase, '/').')/i';
    $replacement = $highlighter;
  }

  return preg_replace($pattern, $replacement, $text);
}

/**
 * Extracts an excerpt from the +text+ surrounding the +phrase+ with a number of characters on each side determined
 * by +radius+. If the phrase isn't found, nil is returned. Ex:
 *   excerpt("hello my world", "my", 3) => "...lo my wo..."
 * If +excerpt_space+ is true the text will only be truncated on whitespace, never inbetween words.
 * This might return a smaller radius than specified.
 *   excerpt("hello my world", "my", 3, "...", true) => "... my ..."
 */
public static function excerpt_text($text, $phrase, $radius = 100, $excerpt_string = '...', $excerpt_space = false)
{
  if ($text == '' || $phrase == '')
  {
    return '';
  }

  $mbstring = extension_loaded('mbstring');
  if($mbstring)
  {
    $old_encoding = mb_internal_encoding();
    @mb_internal_encoding(mb_detect_encoding($text));
  }
  $strlen = ($mbstring) ? 'mb_strlen' : 'strlen';
  $strpos = ($mbstring) ? 'mb_strpos' : 'strpos';
  $strtolower = ($mbstring) ? 'mb_strtolower' : 'strtolower';
  $substr = ($mbstring) ? 'mb_substr' : 'substr';

  $found_pos = $strpos($strtolower($text), $strtolower($phrase));
  $return_string = '';
  if ($found_pos !== false)
  {
    $start_pos = max($found_pos - $radius, 0);
    $end_pos = min($found_pos + $strlen($phrase) + $radius, $strlen($text));
    $excerpt = $substr($text, $start_pos, $end_pos - $start_pos);
    $prefix = ($start_pos > 0) ? $excerpt_string : '';
    $postfix = $end_pos < $strlen($text) ? $excerpt_string : '';

    if ($excerpt_space)
    {
      // only cut off at ends where $exceprt_string is added
      if($prefix)
      {
        $excerpt = preg_replace('/^(\S+)?\s+?/', ' ', $excerpt);
      }
      if($postfix)
      {
        $excerpt = preg_replace('/\s+?(\S+)?$/', ' ', $excerpt);
      }
    }

    $return_string = $prefix.$excerpt.$postfix;
  }

  if($mbstring)
  {
   @mb_internal_encoding($old_encoding);
  }
  return $return_string;
}

/**
 * Word wrap long lines to line_width.
 */
public static function wrap_text($text, $line_width = 80)
{
  return preg_replace('/(.{1,'.$line_width.'})(\s+|$)/s', "\\1\n", preg_replace("/\n/", "\n\n", $text));
}

/**
 * Returns +text+ transformed into html using very simple formatting rules
 * Surrounds paragraphs with <tt>&lt;p&gt;</tt> tags, and converts line breaks into <tt>&lt;br /&gt;</tt>
 * Two consecutive newlines(<tt>\n\n</tt>) are considered as a paragraph, one newline (<tt>\n</tt>) is
 * considered a linebreak, three or more consecutive newlines are turned into two newlines
 */
public static function simple_format_text($text, $options = array())
{
  $css = (isset($options['class'])) ? ' class="'.$options['class'].'"' : '';

  $text = sfToolkit::pregtr($text, array("/(\r\n|\r)/"        => "\n",               // lets make them newlines crossplatform
                                         "/\n{2,}/"           => "</p><p$css>"));    // turn two and more newlines into paragraph

  // turn single newline into <br/>
  $text = str_replace("\n", "\n<br />", $text);
  return '<p'.$css.'>'.$text.'</p>'; // wrap the first and last line in paragraphs before we're done
}

/**
 * Turns all urls and email addresses into clickable links. The +link+ parameter can limit what should be linked.
 * Options are :all (default), :email_addresses, and :urls.
 *
 * Example:
 *   auto_link("Go to http://www.symfony-project.com and say hello to fabien.potencier@example.com") =>
 *     Go to <a href="http://www.symfony-project.com">http://www.symfony-project.com</a> and
 *     say hello to <a href="mailto:fabien.potencier@example.com">fabien.potencier@example.com</a>
 */
public static function auto_link_text($text, $link = 'all', $href_options = array(), $truncate = false, $truncate_len = 35, $pad = '...')
{
  if ($link == 'all')
  {
    return _auto_link_urls(_auto_link_email_addresses($text), $href_options, $truncate, $truncate_len, $pad);
  }
  else if ($link == 'email_addresses')
  {
    return _auto_link_email_addresses($text);
  }
  else if ($link == 'urls')
  {
    return _auto_link_urls($text, $href_options, $truncate, $truncate_len, $pad);
  }
}

/**
 * Turns all links into words, like "<a href="something">else</a>" to "else".
 */
public static function strip_links_text($text)
{
  return preg_replace('/<a[^>]*>(.*?)<\/a>/s', '\\1', $text);
}



/**
 * Turns all urls into clickable links.
 */
public static function _auto_link_urls($text, $href_options = array(), $truncate = false, $truncate_len = 40, $pad = '...')
{
  $href_options = _tag_options($href_options);

  $callback_function = '
    if (preg_match("/<a\s/i", $matches[1]))
    {
      return $matches[0];
    }
    ';

  if ($truncate)
  {
    $callback_function .= '
      else if (strlen($matches[2].$matches[3]) > '.$truncate_len.')
      {
        return $matches[1].\'<a href="\'.($matches[2] == "www." ? "http://www." : $matches[2]).$matches[3].\'"'.$href_options.'>\'.substr($matches[2].$matches[3], 0, '.$truncate_len.').\''.$pad.'</a>\'.$matches[4];
      }
      ';
  }

  $callback_function .= '
    else
    {
      return $matches[1].\'<a href="\'.($matches[2] == "www." ? "http://www." : $matches[2]).$matches[3].\'"'.$href_options.'>\'.$matches[2].$matches[3].\'</a>\'.$matches[4];
    }
    ';

  return preg_replace_callback(
    SF_AUTO_LINK_RE,
    create_function('$matches', $callback_function),
    $text
    );
}

/**
 * Turns all email addresses into clickable links.
 */
public static function _auto_link_email_addresses($text)
{
  // Taken from http://snippets.dzone.com/posts/show/6156
  return preg_replace("#(^|[\n ])([a-z0-9&\-_\.]+?)@([\w\-]+\.([\w\-\.]+\.)*[\w]+)#i", "\\1<a href=\"mailto:\\2@\\3\">\\2@\\3</a>", $text);

  // Removed since it destroys already linked emails 
  // Example:   <a href="mailto:me@example.com">bar</a> gets <a href="mailto:me@example.com">bar</a> gets <a href="mailto:<a href="mailto:me@example.com">bar</a>
  //return preg_replace('/([\w\.!#\$%\-+.]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)+)/', '<a href="mailto:\\1">\\1</a>', $text);
}
    

}

