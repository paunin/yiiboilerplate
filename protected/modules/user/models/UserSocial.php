<?php

Yii::import('application.modules.user.models._base.BaseUserSocial');

/**
 * Class UserSocial
 */
class UserSocial extends BaseUserSocial
{
    /**
     * @param string $className
     * @return CActiveRecord
     */
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * Get or $force_create UserSocial
     *
     * @param $user_social_id
     * @param $service
     * @param array $data
     * @param bool $force_create
     * @return CActiveRecord|UserSocial
     */
    public static function getByService($user_social_id, $service, $data = array(), $force_create = true)
    {

        $user_social = self::model()->findByAttributes(array('user_social_id' => "$user_social_id", 'social_service' => "$service"));
        if(!$user_social && $force_create) {
            //need User for UserSocial to link them
            $user = User::current();
            if(!$user) {
                $user = new User();
                $user->is_active = true;

                $try_name = isset($data['name'])?
                    $data['name']:
                    (isset($data['email'])?$data['email']:"U_{$service}_{$user_social_id}");

                $user->username = User::constructName($try_name);
                $user->save();
            }

            $user_social = new UserSocial();
            $user_social->user_id = $user->id;
            $user_social->social_service = $service;
            $user_social->user_social_id = $user_social_id;

            if(isset($data['url'])) $user_social->url = $data['url'];
            if(isset($data['name'])) $user_social->name = $data['name'];
            if(isset($data['email'])) $user_social->email = $data['email'];
            $user_social->additional_data = json_encode($data);

            $user_social->save();
        }
        return $user_social;
    }

    /**
     * @param bool $force
     * @return bool
     * @throws CException
     */
    public function unbind($force = false)
    {
        if($force)
            return $this->delete();

        $user = $this->user;
        if(count($user->userSocials)>1)
            return $this->delete();

        if(empty($user->email))
            throw new CException(Yii::t('c_app','You can\'t unbind your social account. Set your email address firstly.'));
        if(empty($user->password))
            throw new CException(Yii::t('c_app','You can\'t unbind your social account. Set your password firstly.'));
        return $this->delete();
    }
}