<?php

Yii::import('application.modules.user.models._base.BaseUser');
/**
 * @method array toArray
 * @property UserSettings $userSettings
 * @property UserPlace $userCurrentPlace
 * @property Favorite[] $favoriteUsers
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
                'userCurrentPlace' => array(self::HAS_ONE,'UserPlace','user_id','condition' => 'is_spirit = false'),
                'favoriteUsers' => array(self::HAS_MANY, 'Favorite', 'user_id','condition' => 'type = \''.Favorite::TYPE_USER.'\'' ),
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
            $token->token = md5(rand(0, 9999) . $now . Yii::app()->params['private']['rand_key']);
            $token->expire_at = date("Y-m-d H:i:s", strtotime("+" . Yii::app()->params['private']['app_token_ttl']));
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
            'avatar' => UserAvatar::getAllSize($this->id),
            'created_at' => $this->created_at,
            'last_login' => $this->last_login,
            'current_point' => $this->userCurrentPlace?$this->userCurrentPlace->toArray():null,
            'social' => null,
        );
        return $profile;
    }
}