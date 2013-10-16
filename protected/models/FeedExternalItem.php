<?php

Yii::import('application.models._base.BaseFeedExternalItem');

class FeedExternalItem extends BaseFeedExternalItem
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(
                array('feed_external_id', 'exist', 'attributeName' => 'id', 'className' => 'FeedExternal'),
                array('feed_external_id+guid', 'application.validators.uniqueMultiColumnValidator','message'=>Yii::t('app','feed_external_id + guid already exist')),
                array('text, title', 'filter', 'filter' => array('HtmlTextFilter', 'filterAllHtml')),
            )
        );
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),

        );
    }

}