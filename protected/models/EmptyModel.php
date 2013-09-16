<?php
class EmptyModel {
    public function EmptyFuncForEvent(CEvent $event){
        $context = $event->sender;
        echo 'Event was generated from '.get_class($context);
    }
}