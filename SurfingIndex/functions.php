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
	$eventQu = ('SELECT competition_id, competition_name
		FROM ssa_competitions
		WHERE competition_enddate > now()
		AND competition_startdate < now()');
	
	$eventQuery = myqu($eventQu);
	
	$retXml = '<events>';
	foreach ($eventQuery as $event) {
		$retXml .= '<event>';
		
		$retXml .= '<event_id>'.$event['competition_id'].'</event_id>';
		$retXml .= '<event_name>'.$event['competition_name'].'</event_name>';
		
		$retXml .= '</event>';
	}
	
	$retXml .= '</events>';
	
	return $retXml;
}

function getArchiveEvents() {
	$eventQu = ('SELECT competition_id, competition_name
		FROM ssa_competitions
		WHERE competition_enddate < now()');
	
	$eventQuery = myqu($eventQu);
	
	$retXml = '<events>';
	foreach ($eventQuery as $event) {
		$retXml .= '<event>';
		
		$retXml .= '<event_id>'.$event['competition_id'].'</event_id>';
		$retXml .= '<event_name>'.$event['competition_name'].'</event_name>';
		
		$retXml .= '</event>';
	}
	
	$retXml .= '</events>';
	
	return $retXml;
}

function getEventGroups($eventId) {
	$groupQu = ('SELECT division_id, division_title
		FROM ssa_divisions
		WHERE competition_id = '.$eventId);
	
	$groupQuery = myqu($groupQu);
	
	$retXml = '<groups>';
	foreach ($groupQuery as $group) {
		$retXml .= '<group>';
		
		$retXml .= '<group_id>'.$group['division_id'].'</group_id>';
		$retXml .= '<group_description>'.$group['division_title'].'</group_description>';
		
		$retXml .= '</group>';
	}
	
	$retXml .= '</groups>';
	
	return $retXml;
}

function getEventRounds($divisionId) {
	$roundQu = ('SELECT round_id, round_title
		FROM ssa_rounds
		WHERE division_id = '.$divisionId);
	
	$roundQuery = myqu($roundQu);
	
	$retXml = '<rounds>';
	foreach ($roundQuery as $round) {
		$retXml .= '<round>';
		
		$retXml .= '<round_id>'.$round['round_id'].'</round_id>';
		$retXml .= '<round_description>'.$round['round_title'].'</round_description>';
		
		$retXml .= '</round>';
	}
	
	$retXml .= '</rounds>';
	
	return $retXml;
}

function getEventHeats($roundId) {
	$heatQu = ('SELECT heat_id, heat_description
		FROM ssa_heats
		WHERE round_id = '.$roundId);
	
	$heatQuery = myqu($heatQu);
	
	$retXml = '<heats>';
	foreach ($heatQuery as $heat) {
		$retXml .= '<heat>';
		
		$retXml .= '<heat_id>'.$heat['heat_id'].'</heat_id>';
		$retXml .= '<heat_description>'.$heat['heat_description'].'</heat_description>';
		
		$retXml .= '</heat>';
	}
	
	$retXml .= '</heats>';
	
	return $retXml;
}

function getHeatScores($heatId) {
	/*$scoreQu = ('SELECT su.surfer_name, su.surfer_surname, sc.wave_1, sc.wave_2, sc.wave_3, sc.wave_4, sc.wave_5,
		sc.wave_6, sc.wave_7, sc.wave_8, sc.wave_9, sc.wave_10, sc.wave_11, sc.wave_12, sc.wave_13, sc.wave_14, sc.wave_15
		FROM ssa_scores sc
		INNER JOIN ssa_surfers su
		ON su.surfer_id = sc.surfer_id
		WHERE sc.eventheat_id = '.$heatId);*/
		
	$scoreQu = ('SELECT w.wave_nr, w.value, su.surfer_fullname, m.max, su.surfer_id
		FROM ssa_waves w
		INNER JOIN ssa_scores sc
		ON sc.score_id = w.score_id
		INNER JOIN ssa_surfers su
		ON su.surfer_id = sc.surfer_id
		INNER JOIN (SELECT MAX(w.wave_nr) max, s.heat_id 
		FROM ssa_waves w
		INNER JOIN ssa_scores s
		ON w.score_id = s.score_id
		WHERE w.value IS NOT NULL
		GROUP BY s.heat_id) m
		ON m.heat_id = sc.heat_id
		WHERE w.score_id IN (SELECT score_id FROM ssa_scores WHERE heat_id = '.$heatId.')
		AND w.value IS NOT NULL
		ORDER BY w.score_id, w.wave_nr');
	
	$scoreQuery = myqu($scoreQu);
	
	$lastWave = 0;
	
	/*foreach ($scoreQuery as $score) {
		for ($i = 15; $i > 0; $i--) {
			if ($score['wave_'.$i] != null && $i > $lastWave) {
				$lastWave = $i;
				break;
			}
		}
	}*/
	
	if ($score = $scoreQuery[0]) {
		$lastWave = $score['max'];
	}
	
	$currentSurfer = -1;
	$index = 0;
	$topScore = 0;
	$tempTopScore = 0;
	$scoresArray = array();
	foreach ($scoreQuery as $score) {
		
		if ($currentSurfer != -1 && $currentSurfer != $score['surfer_id']) {
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
	
		if ($currentSurfer != $score['surfer_id']) {
			$topWaves = array();
			$tempTopScore = 0;
			$currentSurfer = $score['surfer_id'];
		}
		
		if ($topWaves[0] == null || ($topWaves[0] != null && ($topWaves[0]['score'] < $score['value']))) {
			if ($topWaves[0] != null) {
				$topWaves[1] = $topWaves[0];
			}
			$topWave = array();
			$topWave['score'] = $score['value'];
			$topWave['index'] = $score['wave_nr'];
			
			$topWaves[0] = $topWave;
		}
		else if ($topWaves[1] == null || ($topWaves[1] != null && ($topWaves[1]['score'] < $score['value']))) {
			$topWave = array();
			$topWave['score'] = $score['value'];
			$topWave['index'] = $score['wave_nr'];
			
			$topWaves[1] = $topWave;
		}
	}
	
	if ($currentSurfer != -1) {
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
	}
	
	$retXml = '<score_data>';
	
	$retXml .= '<wave_count>'.$lastWave.'</wave_count>';
	
	$retXml .= '<scores>';
	
	$currentSurfer = -1;
	$surferIndex = 0;
	foreach ($scoreQuery as $score) {
	
		if ($currentSurfer != -1 && $currentSurfer != $score['surfer_id']) {
			$retXml .= '</waves>';
			
			$retXml .= '</score>';
			$surferIndex++;
		}
	
		if ($currentSurfer != $score['surfer_id']) {
			$topWaves = $scoresArray[$surferIndex];
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
			
			$retXml .= '<surfer_name>'.$score['surfer_fullname'].'</surfer_name>';
			$retXml .= '<surfer_points>'.$points.'</surfer_points>';
			$retXml .= '<surfer_points_needed>'.($topScore - $points).'</surfer_points_needed>';
			
			$retXml .= '<waves>';
			
			$currentSurfer = $score['surfer_id'];
		}
		
		//for ($i = 1; $i <= $lastWave; $i++) {
			$retXml .= '<wave highlight="'.(($score['wave_nr']==$index0 || $score['wave_nr']==$index1)?'true':'false').'">'.$score['value'].'</wave>';
		//}
	}
	if ($currentSurfer != -1) {
		$retXml .= '</waves>';		
		$retXml .= '</score>';
	}
	$retXml .= '</scores></score_data>';
	
	return $retXml;
}
?>