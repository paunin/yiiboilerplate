<?php
/**
 * Class PlaceDeleteAction
 * Change user place
 *
 * @property ApiUserController $controller
 */
class PlaceDeleteAction extends ApiAction
{
    /**
     * @param $id
     */
    public function run($id)
    {
        $user_place = UserPlace::findByPkForUser($id,User::current()->id);

        if (!$user_place)
            $this->controller->forward('apiV0/error404');;

        $this->controller->out($user_place->delete());
    }
}