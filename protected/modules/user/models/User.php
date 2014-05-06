<?php

Yii::import('application.modules.user.models._base.BaseUser');
/**
 * @method array toArray
 */
class User extends BaseUser
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function behaviors()
    {
        return array(
            'CTimestampBehavior' => array(
                'class' => 'zii.behaviors.CTimestampBehavior',
                'createAttribute' => 'created_at',
                'updateAttribute' => 'updated_at',
                'timestampExpression' => "date('Y-m-d H:i:s')"
            ),
            'to_array' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'username', 'email', 'created_at', 'role', 'last_login'
                )
            )

        );
    }

    /**
     * Returns User model by its email
     *
     * @param string $email
     * @access public
     * @return User
     */
    public function findByEmail($email)
    {
        return self::model()->findByAttributes(array('email' => $email));
    }

    /**
     * @var User
     */
    private static $current_user = null;

    /**
     * Return current authorized user
     *
     * @return User|null
     */
    public static function current()
    {
        if (Yii::app()->user->isGuest)
            return null;

        if (!User::$current_user)
            User::$current_user = User::model()->findByPk(Yii::app()->user->getId());

        return User::$current_user;
    }

    /**
     * @param $password
     * @param string $method
     * @return string
     */
    public static function encPass($password, $method = 'md5')
    {
        return md5($password);
    }

    public function __toString()
    {
        return $this->username . '(' . $this->email . ')';
    }


    /**
     * @param Application $app
     * @param bool $force_create
     * @return Token
     */
    public function getToken(Application $app, $force_create = false)
    {
        $now = date('Y-m-d H:i:s');
        $token = Token::model()->find(
            "user_id = :user_id AND application_id = :application_id AND expire_at > :now",
            array(':user_id' => $this->id, ':application_id' => $app->id, ':now' => $now)
        );
        if (!$token && $force_create) {
            $token = new Token();
            $token->user_id = $this->id;
            $token->application_id = $app->id;
            $token->token = md5(rand(0, 9999) . $now . Yii::app()->params['rand_key']);
            $token->expire_at = date("Y-m-d H:i:s", strtotime("+" . Yii::app()->params['app_token_ttl']));
            $token->save();
        }

        if(Yii::app()->params['app_token_need_renew']){
            $now_plus_renew = date("Y-m-d H:i:s", strtotime("+" . Yii::app()->params['app_token_renew_ttl']));


            if($now_plus_renew > $token->expire_at){
                $exp_date = date("Y-m-d H:i:s", strtotime("+" . Yii::app()->params['app_token_ttl']));
                $token->expire_at = $exp_date;
                $token->save();
            }
        }

        return $token;
    }


    public function toFullProfile()
    {
        $profile = array(
            'id' => $this->id,
            'username' => $this->username,
            'name' => null,
            'avatar' => $this->getAvatarsPaths(),
            'created_at' => $this->created_at,
            'last_login' => $this->last_login,
            'social' => null,
        );
        return $profile;
    }

    /**
     * @param $img
     * @param bool $emulate_resize
     * @return array
     */
    public static function  getAvatarsPathsByImg($img, $emulate_resize = true)
    {
        $result = array();
        $img = Yii::getPathOfAlias('webroot') . DIRECTORY_SEPARATOR . Yii::app()->params['path_avatars'] . DIRECTORY_SEPARATOR . $img;
        foreach (Yii::app()->params['user_avatars_sizes'] as $name => $size) {
            $result[$name] = $emulate_resize ?
                Img::getSizedPath($img, $size['w'], $size['h'], true, true)
                : Img::getSizedPath($img, $size['w'], $size['h'], true, true);
        }
        return $result;
    }

    /**
     * @param bool $emulate_resize
     * @return array
     */
    public function getAvatarsPaths($emulate_resize = true)
    {
        $result = array();
        if ($this->avatar_name) {
            $result = User::getAvatarsPathsByImg($this->avatar_name, $emulate_resize);
        }
        return $result;
    }

    /**
     * @param $name
     * @return string
     */
    public static function constructName($name)
    {
        Yii::import('ext.behaviors.SluggableBehavior.Doctrine_Inflector');
        $ret = Doctrine_Inflector::urlize($name);
        $ret = strtr($ret, array('-' => '_'));
        $i = 0;

        $ret2 = $ret;
        while ($i <= 11) {
            $user = self::model()->findByAttributes(array('username' => $ret2));
            if (!$user)
                break;
            $i += 2;
            $ret2 = $ret . $i;
        }

        return $ret2;
    }
}