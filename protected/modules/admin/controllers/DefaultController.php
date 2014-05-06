<?php

class DefaultController extends AController
{
	public function actionIndex()
	{
		$this->render('index');
	}
}