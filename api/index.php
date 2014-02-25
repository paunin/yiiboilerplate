<?php
//require_once(dirname(__FILE__).'/../norun.php');

require_once dirname(__FILE__).'/../protected/vendors/restler/vendor/restler.php';
use Luracast\Restler\Restler;

$r = new Restler();

require_once(dirname(__FILE__).'/Pets.class.php');
$r->addAPIClass('Pets'); // repeat for more


$r->addAPIClass('Resources'); //from restler framework for API Explorer
$r->addFilterClass('RateLimit'); //Add Filters as needed
$r->handle(); //serve the response