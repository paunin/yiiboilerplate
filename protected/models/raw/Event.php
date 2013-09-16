<?php
class Event
{
    /**
     * Навещивает обработчики событий
     * @static
     * @param CComponent $object
     * @return object
     */
    public static function attacheHandlers(CComponent &$object)
    {

        $config = require(Yii::getPathOfAlias('application').'/config/eventsHandlers.php');
        foreach ($config as $event => $handlers) {
            if (!method_exists(get_class($object), $event))
                continue;
            foreach ($handlers as $handler)
                $object->$event = $handler;
        }
    }
}
