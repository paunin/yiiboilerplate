<?php
/**
 * Class HtmlTextFilter
 */
class HtmlTextFilter {
    public static function filterRtf($html,$nl_limit=2){
        $filter = new CHtmlPurifier();

        $filter->options = array(
            'AutoFormat.Linkify' => true,
            'AutoFormat.RemoveEmpty' => true,
            'HTML.MaxImgLength' => '800',
            'CSS.MaxImgLength' => '800',
            'AutoFormat.AutoParagraph' => false,
            'HTML.Nofollow' => true,
            'HTML.AllowedElements' => array('br', 'a', 'img', 'p', 'ul', 'ol', 'span', 'li', 'i', 'b', 'strong', 'em'),
        );
        $out = $filter->purify($html);
        $out = preg_replace('/(<br[^>]*>)(?:\s*\1)+/',str_repeat('$1',$nl_limit),$out);
        return $out;

    }
} 