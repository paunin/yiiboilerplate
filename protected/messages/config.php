<?php
/**
 * This is the configuration for generating message translations
 * for the Yii framework. It is used by the 'yiic message' command.
 */
return array(
    'sourcePath' => dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
    'messagePath' => dirname(__FILE__).DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'messages',
    'languages' => array('ru'),
    'fileTypes' => array('php'),
    'overwrite' => true,
    'removeOld' => true,
    'translator' => '(?:MyYii|Yii)::t',
    'sort'       => 'new',
    'exclude' => array(
        '.svn',
        '.git',
        '.gitignore',
    ),
);
