<?php
echo "-----------------------------------\n\n".'         Loading fixtures'."\n\n-----------------------------------\n\n";
$command = 'php';
$yiic = dirname(__FILE__).'/../yiic';

$load = "$command $yiic DbWorker load";
$migrate = "$command $yiic migrate --interactive=0";

exec($load);
exec($migrate);

require_once('bootstrap.php');
