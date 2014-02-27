<?php

/**
 * Class Api
 */
class Api {
    private $api_version = '0.0.1';

    /**
     * Get API versionGet
     *
     * In order u should use smile for work with me
     *
     * @return string
     */
    public function info(){
        return Yii::t('api','Wellcome to API').' - '.$this->api_version;
    }

    /**
     * Get user ID
     *
     * Get current API authorized (with token|api_key) user ID
     *
     * @return Integer
     * @throws 403 if user not authorized (with token|api_key)
     */
    public function userId(){
        if(Yii::app()->user->isGuest)
            YiiRestler::error(403,Yii::t('api','Can\'t get id'));
        return Yii::app()->user->getId();
    }

    /**
     * Get token
     *
     * Get token for current authorized on frontend application/site user
     *
     * @return Array
     * @throws 403 if user not authorized on frontend application
     */
    public function token(){


        $app = Application::model()->findByAttributes(array('id'=>Yii::app()->params['app_own_id']));
        /** @var User $user */
        $user = User::model()->findByPk(Yii::app()->siteUser->getId());
        if(!$user)
            YiiRestler::error(403,Yii::t('api','Can\'t get token'));
        $token = $user->getToken($app,true);
        $ret = $token->toArray();
        //$ret['user_id'] = Yii::app()->siteUser->getId();
        return $ret;
    }



    /**
     * Test api
     *
     * Test some cases in current API
     *
     * @url PUT _test/{type}
     * @throws 404 just 404 error
     * @throws 403 just 403 error
     * @param string $type test case  {@choice object,error404,error403}
     * @return ReturnExampleObject
     */
    public function test($type = "error404"){
        switch($type){
            case 'error404':
                YiiRestler::error(404,'just 404');
                break;
            case 'error403':
                YiiRestler::error(403,'just 403');
                break;
            case 'object':
                return new ReturnExampleObject();
                break;
        }

    }
    /**
     * Test api
     *
     * Test user level Access
     *
     * @url PUT _test_userResource
     * @access protected
     * @class  YiiRestlerAccessControl {@requires user}
     */
    public function  test_userResource()
    {
        return "protected api, only user can access";
    }
    /**
     * Test api
     *
     * Test admin level Access
     *
     * @url PUT _test_adminResource
     * @access protected
     * @class  YiiRestlerAccessControl {@requires admin}
     */
    public function test_adminResource()
    {
        return "protected api, only admin can access";
    }

    /**
     * Test api
     *
     * Test hybrid access - different result for authorized and non-authorized user
     *
     * @url PUT _test_hybridResource
     * @access hybrid
     * @class  YiiRestlerAccessControl {@requires user}
     * @return Integer|String
     */
    public function test_hybridResource()
    {
        return !Yii::app()->user->isGuest?Yii::app()->user->getId():'NO';
    }
}

class ReturnExampleObject {
    /** @var string   */
    public $one_p = '1';
    /** @var float  */
    public $two_p = 2.2;
    /** @var string  */
    public $three_p = 'q';
    /** @var string  */
    public $three2_p;

}


