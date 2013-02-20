<?php
include('class.upload.php');
include('dbconnection.php');

function myqu($sQuery) {
	$conn = new dbconnection();
	return $conn->_myqu($sQuery);
}

function myqui($sQuery) {
	$conn = new dbconnection();
	$conn->_myqui($sQuery);
}

function getCurrentEvents() {
	$eventQu = ('SELECT event_id, event_name
		FROM ssa_events
		WHERE event_enddate > now()
		AND event_startdate < now()');
	
	$eventQuery = myqu($eventQu);
	
	$retXml = '<events>';
	foreach ($eventQuery as $event) {
		$retXml .= '<event>';
		
		$retXml .= '<event_id>'.$event['event_id'].'</event_id>';
		$retXml .= '<event_name>'.$event['event_name'].'</event_name>';
		
		$retXml .= '</event>';
	}
	
	$retXml .= '</events>';
	
	return $retXml;
}

function getArchiveEvents() {
	$eventQu = ('SELECT event_id, event_name
		FROM ssa_events
		WHERE event_enddate < now()');
	
	$eventQuery = myqu($eventQu);
	
	$retXml = '<events>';
	foreach ($eventQuery as $event) {
		$retXml .= '<event>';
		
		$retXml .= '<event_id>'.$event['event_id'].'</event_id>';
		$retXml .= '<event_name>'.$event['event_name'].'</event_name>';
		
		$retXml .= '</event>';
	}
	
	$retXml .= '</events>';
	
	return $retXml;
}

function getEventGroups($eventId) {
	$groupQu = ('SELECT eventgroup_id, eventgroup_description
		FROM ssa_eventgroups
		WHERE event_id = '.$eventId);
	
	$groupQuery = myqu($groupQu);
	
	$retXml = '<groups>';
	foreach ($groupQuery as $group) {
		$retXml .= '<group>';
		
		$retXml .= '<group_id>'.$group['eventgroup_id'].'</group_id>';
		$retXml .= '<group_description>'.$group['eventgroup_description'].'</group_description>';
		
		$retXml .= '</group>';
	}
	
	$retXml .= '</groups>';
	
	return $retXml;
}

function getEventHeats($groupId) {
	$heatQu = ('SELECT eventheat_id, eventheat_description
		FROM ssa_eventheat
		WHERE eventgroup_id = '.$groupId);
	
	$heatQuery = myqu($heatQu);
	
	$retXml = '<heats>';
	foreach ($heatQuery as $heat) {
		$retXml .= '<heat>';
		
		$retXml .= '<heat_id>'.$heat['eventheat_id'].'</heat_id>';
		$retXml .= '<heat_description>'.$heat['eventheat_description'].'</heat_description>';
		
		$retXml .= '</heat>';
	}
	
	$retXml .= '</heats>';
	
	return $retXml;
}

function getHeatScores($heatId) {
	$scoreQu = ('SELECT su.surfer_name, su.surfer_surname, sc.wave_1, sc.wave_2, sc.wave_3, sc.wave_4, sc.wave_5,
		sc.wave_6, sc.wave_7, sc.wave_8, sc.wave_9, sc.wave_10, sc.wave_11, sc.wave_12, sc.wave_13, sc.wave_14, sc.wave_15
		FROM ssa_scores sc
		INNER JOIN ssa_surfers su
		ON su.surfer_id = sc.surfer_id
		WHERE sc.eventheat_id = '.$heatId);
	
	$scoreQuery = myqu($scoreQu);
	
	$lastWave = 0;
	
	
	foreach ($scoreQuery as $score) {
		for ($i = 15; $i > 0; $i--) {
			if ($score['wave_'.$i] != null && $i > $lastWave) {
				$lastWave = $i;
				break;
			}
		}
	}
	
	$retXml = '<score_data>';
	
	$retXml .= '<wave_count>'.$lastWave.'</wave_count>';
	
	$retXml .= '<scores>';
	
	foreach ($scoreQuery as $score) {
		$retXml .= '<score>';
		
		$retXml .= '<surfer_name>'.$score['surfer_name'].'</surfer_name>';
		$retXml .= '<surfer_surname>'.$score['surfer_surname'].'</surfer_surname>';
		
		$retXml .= '<waves>';
		for ($i = 1; $i <= $lastWave; $i++) {
			$retXml .= '<wave>'.$score['wave_'.$i].'</wave>';
		}
		$retXml .= '</waves>';
		
		$retXml .= '</score>';
	}
	
	$retXml .= '</scores></score_data>';
	
	return $retXml;
}
?>