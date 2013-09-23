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
    'removeOld' => false,
    'translator' => '(?:MyYii|Yii)::t',
    'exclude' => array(
        '.svn',
        '.git',
        '.gitignore',
        'yiilite.php',
        'yiit.php',
        '/i18n/data',
        '/messages',
        '/vendors',
        '/yii',
        '/extensions',
        '/_docs',

    ),
);
