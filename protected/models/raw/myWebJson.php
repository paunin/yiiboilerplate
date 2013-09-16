<?php
class myWebJson
{
/**
 * generate json ans for ajax
 *
 * @param string $data
 * @param integer $status
 * @param string $status_code
 * 
 * @return string
 */
	public static function get($data='no data',  $status_code = 0, $status_text = 'ok'  ) {

     return (string) json_encode(array(
        'status_code'=> $status_code,
        'status_text' =>$status_text,
        'data'=>$data

     ));
	}
}