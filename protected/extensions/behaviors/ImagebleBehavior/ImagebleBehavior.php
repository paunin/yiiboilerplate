<?php

class ImagebleBehavior extends CActiveRecordBehavior
{

    public $searchFields = array();
    public $excludedDomains = array();
    public $saveDir = '/tmp/';
    public $webDir = '/content/'; //alias of $saveDir for user from doc_root
    public $verbBaseField = null;
    public $verbDirBaseField = 'slug';
    public $maxW = array();
    public $optimize = true;
    public $saveOrigin = true;



    public function beforeSave($event){
        return $this->saveImages();
    }
    /**
     * @return int|void
     */
    public function saveImages()
    {
        //var_dump($this->searchImages());
        $i = 0;
        foreach ($this->searchImages() as $field => $urls) {
            $replaces = array();
            foreach ($urls as $url) {

                $place_dir = $this->verbDirBaseField ? $this->owner->{$this->verbDirBaseField} . '/' : '';
                $place_file = ($this->verbBaseField ? $this->owner->{$this->verbBaseField} : '')
                    . '_' . $i . '.' . substr(pathinfo($url, PATHINFO_EXTENSION),0,3);

                $place = $place_dir . $place_file;

                $save_dir = $this->saveDir.$place_dir;
                if(!is_dir($save_dir))
                    mkdir($save_dir,0777,true);
                set_time_limit(60);
                $img = @file_get_contents($url);
                if($img){
                    $i++;
                    file_put_contents($this->saveDir.$place,$img);
                    if($this->optimize){
                            $replaces[$url] = Img::getSizedPath(
                                $this->saveDir.$place,
                                $this->maxW[$field],
                                $this->maxW[$field]*3,
                                true,
                                false,
                                'top',
                                'center',
                                $this->saveDir.$place_dir . '_' . $place_file,
                                !$this->saveOrigin
                            );
                    }else{
                            $replaces[$url] = $this->webDir.$place;
                    }
                }


            }

            $this->owner->$field = strtr($this->owner->$field,$replaces);
        }
        return $i;
    }

    /**
     * @return array
     * Array(
     *   [text] => Array(
     *       [0] => http://images.businessweek.com/ss/08/07/0717_idea_winners/image/g_touchsight.jpg
     *       [1] => http://www.funforever.net/wp-content/touch_sight2.jpg
     *   )
     *)
     */
    public function searchImages()
    {
        $result = array();
        foreach ($this->searchFields as $field) {
            $r = $this->searchImagesInField($field);
            if(!empty($r))
                $result[$field] = $r;
        }
        //var_dump($result);
        return $result;
    }
//<img src="http://dev.zodroid.ru/external/autouploads/548/fotoapparat-touch-sight_2.jpg?7888" alt="" width="680" height="401">
//<img src="http://images.businessweek.com/ss/08/07/0717_idea_winners/image/g_touchsight.jpg" alt="" width="680" height="401">
    /**
     *
     * @param $field
     * @return array
     */
    public function searchImagesInField($field)
    {
        $result = array();
        $matches = array();
        if(preg_match_all('/<img[^>]*src\s*=\s*[\'"]\s*(http:\/\/[^>]*\.(png|jpg|gif)?\s*((\?|%3f)[^\'"]*)?)\s*([\'"])?/i', $this->owner->$field, $matches)) {
            foreach ($matches[1] as $match) {

                $domain = parse_url($match, PHP_URL_HOST);
                if(in_array($domain, $this->excludedDomains))
                    continue;
                $result[] = $match;
            }
        }

        return $result;
    }

} 