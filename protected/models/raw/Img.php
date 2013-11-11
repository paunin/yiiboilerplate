<?php
Yii::import('application.extensions.image.Image');
class Img
{

    public static function makeSizedPath(
        $path,
        $max_w,
        $max_h,
        $web = true,
        $need_crop = false,
        $crop_top = 'top',
        $crop_left = 'center',
        $emulate = true
    )
    {
        $path_info = pathinfo($path);
        $file_name = $max_w . '_' . $max_h . '.' . $path_info['extension'];
        $file_dir = self::getCachePathForImg($path) . ($need_crop ? ('with_crop_' . $crop_top . '_' . $crop_left)
                : 'no_crop') . '/';

        if (!$emulate && !is_dir($file_dir)) {
            mkdir($file_dir, 0755, true);
        }

        $spath = $file_dir . $file_name;
        //for web
        if ($web) {
            return '/' . self::makeRelativePath($spath);
        }
        return $spath;
    }

    public static function getSizedPath(
        $path,
        $max_w,
        $max_h,
        $web = true,
        $need_crop = false,
        $crop_top = 'top',
        $crop_left = 'center',
        $new_path = null,
        $remove_orig = false
    )
    {
        //build path
        if (!$new_path) {
            $spath = self::makeSizedPath($path, $max_w, $max_h, false, $need_crop, $crop_top, $crop_left, false);
        } else {
            $spath = $new_path;
        }
        //web img
        if (preg_match('/^(http|https|ftp):\/\/.*/i', $path)) {
            $tmp_path = YiiBase::getPathOfAlias('application.runtime') . '/img' . md5($path) . '.png';
            if (!is_file($tmp_path)) {
                if (!$fgc = @file_get_contents($path))
                    return null;
                file_put_contents($tmp_path, $fgc);
            }
            $path = $tmp_path;
        }

        //no input file
        if (!is_file($path)) {
            return null;
        }

        //no yet file
        if (!is_file($spath)) {
            try {
                $image = new Image($path);
            } catch (Exception $exc) {
                return null;
            }

            $image->quality(100);
            if ($need_crop) {
                if ($max_h / $image->height > $max_w / $image->width) {
                    $r = $max_w / $max_h;
                    $crop_h = $image->height;
                    $crop_w = $image->height * $r;
                } else {
                    $r = $max_h / $max_w;
                    $crop_w = $image->width;
                    $crop_h = $image->width * $r;
                }
                $image->crop($crop_w, $crop_h, $crop_top, $crop_left);
            }

            $image->resize($max_w, $max_h);

            try {
                $image->save($spath);
            } catch (Exception $exc) {
                return null;
            }

        }
        //remove origin
        if ($remove_orig)
            unlink($path);

        //for web
        if ($web) {
            return '/' . self::makeRelativePath($spath);
        }

        return $spath;
    }

    private static function makeRelativePath($path)
    {
        $root = str_replace('\\', '/', preg_replace('/.protected?/', '', Yii::getPathOfAlias('application')));
        $ret = str_replace($root . '/', '', str_replace('\\', '/', $path));
        return $ret;
    }

    /**
     * @static
     * @param string $path
     * @return string
     */
    private static function getCachePathForImg($path)
    {
        $cache_root = preg_replace('/.protected?/', '', Yii::getPathOfAlias('application')) . '/' . Yii::app()->params['path_img_cache'];
        $path_info = pathinfo($path);
        return $cache_root . DIRECTORY_SEPARATOR .self::makeRelativePath($path_info['dirname']) . '/' . $path_info['basename'] . '/';
    }

    /**
     * @static
     * @param string $path
     * @param bool $with_cache
     * @return void
     */
    public static function remove($path, $with_cache = true)
    {
        if (is_file($path)) {
            unlink($path);
            if ($with_cache) {
                $cdir = self::getCachePathForImg($path);
                if (is_dir($cdir)) {
                    Cut::delDirTree($cdir);
                }
            }
        }
    }
}
