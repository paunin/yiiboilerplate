<?php

/**
 * This is the model base class for the table "content".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Content".
 *
 * Columns in table "content" available as properties of the model,
 * and there are no model relations.
 *
 * @property integer $id
 * @property string $title
 * @property string $slug
 * @property string $text
 * @property string $created_at
 * @property string $updated_at
 *
 */
abstract class BaseContent extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'content';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Content|Contents', $n);
	}

	public static function representingColumn() {
		return 'title';
	}

	public function rules() {
		return array(
			array('title, slug, text, created_at', 'required'),
			array('title', 'length', 'max'=>512),
			array('slug', 'length', 'max'=>255),
			array('updated_at', 'safe'),
			array('updated_at', 'default', 'setOnEmpty' => true, 'value' => null),
			array('id, title, slug, text, created_at, updated_at', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'id' => Yii::t('app', 'ID'),
			'title' => Yii::t('app', 'Title'),
			'slug' => Yii::t('app', 'Slug'),
			'text' => Yii::t('app', 'Text'),
			'created_at' => Yii::t('app', 'Created At'),
			'updated_at' => Yii::t('app', 'Updated At'),
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('id', $this->id);
		$criteria->compare('title', $this->title, true);
		$criteria->compare('slug', $this->slug, true);
		$criteria->compare('text', $this->text, true);
		$criteria->compare('created_at', $this->created_at, true);
		$criteria->compare('updated_at', $this->updated_at, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}