<?php
class EmptyModel {
    public function EmptyFuncForEvent(CEvent $event){
        $context = $event->sender;
        echo 'Event was generated from '.get_class($context)."<br/>";
    }
    public function EmptyFuncForEvent2(CEvent $event){
        $context = $event->sender;
        echo 'Event 2 was generated from '.get_class($context)."<br/>";
    }
}