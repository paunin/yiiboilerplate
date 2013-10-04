<?php
class ApiException extends CException
{

    public function getHash() {
        return array(
            'status' => $this->code?$this->code:666,
            'message' => $this->message,
            'result' => YII_DEBUG?$this->getTraceAsString():''
        );
    }
}