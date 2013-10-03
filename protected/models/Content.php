<?php

Yii::import('application.models._base.BaseContent');

class Content extends BaseContent
{
    public function rules()
    {
        return array(
            array('title, text', 'required'),
            array('title', 'length', 'max' => 512),
            array('slug', 'length', 'max' => 255),
            array('updated_at', 'safe'),
            array('updated_at', 'default', 'setOnEmpty' => true, 'value' => null),
            array('id, title, slug, text, created_at, updated_at', 'safe', 'on' => 'search'),
        );
    }

    public function behaviors()
    {
        return array(
            'sluggable' => array(
                'class' => 'ext.behaviors.SluggableBehavior.SluggableBehavior',
                'columns' => array('title'),
                'unique' => true,
                'update' => true,
            ),
            'CTimestampBehavior' => array(
                'class' => 'zii.behaviors.CTimestampBehavior',
                'createAttribute' => 'created_at',
                'updateAttribute' => 'updated_at',
                'timestampExpression' => "date('Y-m-d H:i:s')"
            ),
            'solr' => array(
                'class' => 'ext.behaviors.SolrBehavior.SolrBehavior',
                'instanceClass' => 'ContentSolr',
                'fieldsMap' => array(
                    'slug' => 'slug',
                    'title' => 'title&name',
                    'title+text' => 'text'
                )
            )

        );

    }


    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }
}