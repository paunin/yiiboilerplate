<?php

require_once dirname(__FILE__).'/../protected/components/api/YiiRestler.php';
require_once dirname(__FILE__).'/../protected/components/api/YiiRestlerAccessControll.php';

$r = new YiiRestler();
$r->setAPIVersion(2);

$r->addAPIClass('Api'); // repeat for more

$r->setSupportedFormats('JsonFormat', 'XmlFormat');
$r->addAuthenticationClass('YiiRestlerAccessControl');
$r->addAPIClass('Resources'); //from restler framework for API Explorer
//$r->addFilterClass('RateLimit'); //Add Filters as needed
$r->handle(); //serve the response
