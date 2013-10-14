<?php
/**
 * Class FavoriteGetAction
 * Get Favorites Profiles action
 *
 * @property ApiLocationController $controller
 */
class FavoriteGetAction extends ApiAction
{
    public function run()
    {
        $result = array();

        $favorites = Favorite::model()
            ->with(
                array(
                    'favoriteUser' => array('together' => true),
                    'favoriteUser.userCurrentPlace' => array('alias' => 'u_place','together' => true)
                )
            )
            ->findAll(
                array(
                    'order'=>'t.created_at DESC',
                    'condition'=>'t.user_id = :user_id',
                    'params'=>array(':user_id' => Yii::app()->user->getId()))
            );
        foreach ($favorites as $favUser) {
            /**@var Favorite $favUser */
            $result[] = $favUser->favoriteUser->toFullProfile();
        }


        $this->controller->out($result);
    }
}