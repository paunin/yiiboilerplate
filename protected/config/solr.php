<?php
Yii::setPathOfAlias('packages', dirname(__FILE__) . "/../packages/");
return array(
    'aliases' => array(
        "packages" => Yii::getPathOfAlias('packages'),
    ),
    'import' => array(
        'application.models.solr.*', //solr
        'packages.solr.*'
    ),
    'components' => array(
        'solrContent' => array(
            "class" => "packages.solr.ASolrConnection",
            "clientOptions" => array(
                "hostname" => "localhost",
                "port" => 8983,
                'path' => '/solr/content'
            ),
        ),
        'solrUser' => array(
            "class" => "packages.solr.ASolrConnection",
            "clientOptions" => array(
                "hostname" => "localhost",
                "port" => 8983,
                'path' => '/solr/user'
            ),
        )
    )
);