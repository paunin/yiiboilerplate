<?php
/**
 * User: paunin
 * Date: 20.03.14
 * Time: 22:38
 */

class HttpSession extends CHttpSession {
    /**
     * Updates the current session id with a newly generated one .
     * Please refer to {@link http://php.net/session_regenerate_id} for more details.
     * @param boolean $deleteOldSession Whether to delete the old associated session file or not.
     * @since 1.1.8
     */
    public function regenerateID($deleteOldSession=false)
    {
        @session_regenerate_id($deleteOldSession);
    }

} 