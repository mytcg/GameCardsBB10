<?php
include('settings.php');

/*
this page handles requests from the handset
*/

date_default_timezone_set('Africa/Johannesburg'); 

if ($_GET['test']) {
	echo 'surf test!';
	
	exit;
}

if ($_GET['currentevents']) {
	$currentEvents = getCurrentEvents();
	
	echo $currentEvents;
	
	exit;
}

if ($_GET['archiveevents']) {
	$archiveEvents = getArchiveEvents();
	
	echo $archiveEvents;
	
	exit;
}

if ($event_id = $_GET['eventgroups']) {
	$eventGroups = getEventGroups($event_id);
	
	echo $eventGroups;
	
	exit;
}

if ($group_id = $_GET['eventheats']) {
	$eventHeats = getEventHeats($group_id);
	
	echo $eventHeats;
	
	exit;
}

if ($heat_id = $_GET['heatscores']) {
	$heatScores = getHeatScores($heat_id);
	
	echo $heatScores;
	
	exit;
}

?>