<?php
/**
 *  Configure in sender class
 *
 *     public function init(){ //for model
 *           Event::attacheHandlers($this);
 *     }
 *
 * Define function in sender class
 *
 *     public function onSomething(CEvent $event){
 *           $this->raiseEvent('onSomething', $event);
 *     }
 *
 * Then Call somewhere in  sender class
 *
 *      $this->onSomething(new CEvent($this));
 *
 */
return array(
    'onSomething' => array(
        array('EmptyModel', 'EmptyFuncForEvent'),
        array('EmptyModel', 'EmptyFuncForEvent2'),
    ),
);
?>