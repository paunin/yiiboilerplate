<?php

Yii::import('application.modules.user.models._base.BaseUser');
/**
 * @method array toArray
 * @property UserSettings $userSettings
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
        if(Yii::app()->user->isGuest)
            return null;

        if(!User::$current_user)
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
        if(!User::$user_settings) {
            User::$user_settings = $this->userSettings;
            if(empty(User::$user_settings)) {
                User::$user_settings = new UserSettings();
                User::$user_settings->user_id = $this->id;
                User::$user_settings->save();
            }
        }
        if($attr){
            return User::$user_settings->hasAttribute($attr)?User::$user_settings->getAttribute($attr):null;
        }
        return User::$user_settings;
    }
}