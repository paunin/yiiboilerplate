<?php

Yii::import('application.modules.user.models._base.BaseUser');
/**
 * @property UserSettings $userSettings
 */
class User extends BaseUser
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function relations() {
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
     * Return current authorized user
     *
     * @return User|null
     */
    public static function current()
    {
        if(Yii::app()->user->isGuest)
            return null;
        return User::model()->findByPk(Yii::app()->user->getId());
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
     * @return UserSettings
     */
    public function getOrCreateUserSettings(){
        $user_settings = $this->userSettings;
        if(empty($user_settings)){
            $user_settings = new UserSettings();
            $user_settings->user_id = $this->id;
            $user_settings->save();
        }
        return $user_settings;
    }

}