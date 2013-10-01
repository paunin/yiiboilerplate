<?php
/**
 * Class ContentSolr
 * @property int $id
 * @property str $name
 * @property str $title
 * @property str $text
 * @property str $slug
 *
 */
class ContentSolr extends ASolrDocument{
    /**
     * Required for all ASolrDocument sub classes
     * @see ASolrDocument::model()
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }
    /**
     * @return ASolrConnection the solr connection to use for this model
     */
    public function getSolrConnection() {
        return Yii::app()->solrContent;
    }	
 
}