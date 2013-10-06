<?php
/**
 * Class PlaceGetAction
 * Get User PLACES
 *
 * @property ApiUserController $controller
 */
class PlaceGetAction extends ApiAction
{
    public function run()
    {
        $result = array();

        $user_places = User::current()->userPlaces;
        foreach($user_places as $user_place){
            $result[] = $user_place->toArray();
        }

        $this->controller->out(
            $result
        );
    }
}