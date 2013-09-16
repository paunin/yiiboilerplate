<?php

class DefaultController extends Controller
{

    /**
     * Lists all models.
     */
    public function actionIndex()
    {
        $this->render('/user/index', array( ));
    }

}