<?php

class UserAvatar {
    /**
     * @param int $user_id User id
     * @return array of avatars
     */
    public static function getAllSize($user_id){
        return array(
            'small' => 'http://placemeup.com/todoavatar',
            'medium' => 'http://placemeup.com/todoavatar',
            'big' => 'http://placemeup.com/todoavatar',
            'by_size' => array(
                '90x90' => 'http://placemeup.com/todoavatar',
                '200x200' => 'http://placemeup.com/todoavatar'
            )
        );
    }
} 