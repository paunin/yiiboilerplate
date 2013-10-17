<?php

Yii::import('application.modules.user.models._base.BaseUser');
/**
 * @method array toArray
 * @property UserSettings $userSettings
 * @property UserPlace $userCurrentPlace
 * @property Favorite[] $favoriteUsers
 * @property int $messagesCountNew
 */
class User extends BaseUser
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }



    public function relations()
    {
        $relations = parent::relations();
        $relations['userSettings'] = array(self::HAS_ONE, 'UserSettings', 'user_id');
        $relations = array_merge(
            $relations,
            array(
                'userCurrentPlace' => array(self::HAS_ONE,'UserPlace','user_id','on' => 'is_spirit = false'),
                'favoriteUsers' => array(self::HAS_MANY, 'Favorite', 'user_id', 'on' => 'type = \''.Favorite::TYPE_USER.'\'' ),
                'messagesCountNew' => array(self::STAT, 'Message', 'to_user', 'condition' => 'is_new = true'),
                'messagesTo' => array(self::HAS_MANY, 'Message', 'to_user_id'),
                'messagesFrom' => array(self::HAS_MANY, 'Message', 'from_user_id'),
            )
        );
        return $relations;
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
     * @var UserSettings|null
     */
    private static $user_settings = null;

    /**
     * @param null|string $attr
     * @return mixed|null|UserSettings
     */
    public function getUserSettings($attr = null)
    {
        if (!User::$user_settings) {
            User::$user_settings = $this->userSettings;
            if (empty(User::$user_settings)) {
                User::$user_settings = new UserSettings();
                User::$user_settings->user_id = $this->id;
                User::$user_settings->save();
            }
        }
        if ($attr) {
            return User::$user_settings->hasAttribute($attr) ? User::$user_settings->getAttribute($attr) : null;
        }
        return User::$user_settings;
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

        return $token;
    }

    /**
     * @param LocationPoint $point
     * @return UserPlace|null
     */
    public function getPlace(LocationPoint $point)
    {
        return UserPlace::model()->findByAttributes(array('cx' => $point->cx, 'cy' => $point->cy, 'user_id' => $this->id));

    }

    public function toFullProfile(){
        $profile = array(
            'id' => $this->id,
            'username' => $this->username,
            'name' => null,
            'avatar' => $this->getAvatarsPaths(),
            'created_at' => $this->created_at,
            'last_login' => $this->last_login,
            'current_point' => $this->userCurrentPlace?$this->userCurrentPlace->toArray():null,
            'social' => null,
        );
        return $profile;
    }

    /**
     * @param $img
     * @param bool $emulate_resize
     * @return array
     */
    public static function  getAvatarsPathsByImg($img,$emulate_resize = true){
        $result = array();
        $img = Yii::getPathOfAlias('webroot') . DIRECTORY_SEPARATOR . Yii::app()->params['path_avatars']. DIRECTORY_SEPARATOR . $img;
        foreach(Yii::app()->params['user_avatars_sizes'] as $name => $size){
            $result[$name] = $emulate_resize?
                Img::getSizedPath($img, $size['w'], $size['h'],true,true)
                :Img::getSizedPath($img, $size['w'], $size['h'],true,true);
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
        if($this->avatar_name){
            $result = User::getAvatarsPathsByImg($this->avatar_name,$emulate_resize);
        }
        return $result;
    }
}