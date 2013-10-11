<?php
/**
 * Class FavoritePostAction
 * Create Favorite Profile action
 *
 * @property ApiLocationController $controller
 */
class FavoritePostAction extends ApiAction
{
    /**
     * @param $id User id to ad into favs
     * @throws CHttpException
     */
    public function run($id)
    {
        if($id == User::current()->id)
            throw new CHttpException(701,Yii::t('app',"You can't add yourself to favorites"));

        /** @var User $favUser */
        $favUser = User::model()->findByPk($id);
        if(!$favUser)
            throw new CHttpException(404,Yii::t('app',"User not found"));

        $fav = new Favorite();
        $fav->user_id = User::current()->id;
        $fav->type = Favorite::TYPE_USER;
        $fav->favorite_id = $favUser->id;


        if ($fav->validate()) {
            $this->controller->out($fav->save());
        } else {
            $this->controller->out(true);//silent skip
            //$this->controller->outError($fav->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }

    }
}