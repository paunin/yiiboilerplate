<?php
class ExtEAuthUserIdentity extends EAuthUserIdentity
{
    public function getService(){
        return $this->service;
    }

}