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
	
	$index = 0;
	$topScore = 0;
	$scoresArray = array();
	foreach ($scoreQuery as $score) {
		$topWaves = array();
		$tempTopScore = 0;
		for ($i = 1; $i <= $lastWave; $i++) {
			if ($score['wave_'.$i] != null) {
				if ($topWaves[0] == null || ($topWaves[0] != null && ($topWaves[0]['score'] < $score['wave_'.$i]))) {
					if ($topWaves[0] != null) {
						$topWaves[1] = $topWaves[0];
					}
					$topWave = array();
					$topWave['score'] = $score['wave_'.$i];
					$topWave['index'] = $i;
					
					$topWaves[0] = $topWave;
				}
				else if ($topWaves[1] == null || ($topWaves[1] != null && ($topWaves[1]['score'] < $score['wave_'.$i]))) {
					$topWave = array();
					$topWave['score'] = $score['wave_'.$i];
					$topWave['index'] = $i;
					
					$topWaves[1] = $topWave;
				}
			}
		}
		
		if ($topWaves[0] != null) {
			$tempTopScore += $topWaves[0]['score'];
		}
		if ($topWaves[1] != null) {
			$tempTopScore += $topWaves[1]['score'];
		}
		if ($tempTopScore > $topScore) {
			$topScore = $tempTopScore;
		}
		$scoresArray[$index] = $topWaves;
		$index++;
	}
	
	$retXml = '<score_data>';
	
	$retXml .= '<wave_count>'.$lastWave.'</wave_count>';
	
	$retXml .= '<scores>';
	
	$index = 0;
	foreach ($scoreQuery as $score) {
		$topWaves = $scoresArray[$index];
		$index0 = -1;
		$index1 = -1;
		$points = 0;
		
		if ($topWaves[0] != null) {
			$index0 = $topWaves[0]['index'];
			$points += $topWaves[0]['score'];
		}
		if ($topWaves[1] != null) {
			$index1 = $topWaves[1]['index'];
			$points += $topWaves[1]['score'];
		}
		
		$retXml .= '<score>';
		
		$retXml .= '<surfer_name>'.$score['surfer_name'].'</surfer_name>';
		$retXml .= '<surfer_surname>'.$score['surfer_surname'].'</surfer_surname>';
		$retXml .= '<surfer_points>'.$points.'</surfer_points>';
		$retXml .= '<surfer_points_needed>'.($topScore - $points).'</surfer_points_needed>';
		
		$retXml .= '<waves>';
		for ($i = 1; $i <= $lastWave; $i++) {
			$retXml .= '<wave highlight="'.(($i==$index0 || $i==$index1)?'true':'false').'">'.$score['wave_'.$i].'</wave>';
		}
		$retXml .= '</waves>';
		
		$retXml .= '</score>';
		$index++;
	}
	
	$retXml .= '</scores></score_data>';
	
	return $retXml;
}
?>