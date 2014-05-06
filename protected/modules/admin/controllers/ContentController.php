<?php

class ContentController extends AController {


	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Content'),
		));
	}

	public function actionCreate() {
		$model = new Content;


		if (isset($_POST['Content'])) {
			$model->setAttributes($_POST['Content']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Content');


		if (isset($_POST['Content'])) {
			$model->setAttributes($_POST['Content']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Content')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Content');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Content('search');
		$model->unsetAttributes();

		if (isset($_GET['Content']))
			$model->setAttributes($_GET['Content']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}