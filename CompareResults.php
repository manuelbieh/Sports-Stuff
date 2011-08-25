<?php
/**
 * Small class to compare two results, e.g. for a prediction game
 *
 * @author Manuel Bieh
 * @url http://www.manuel-bieh.de/
 * @version 1.0
 * @license http://www.gnu.org/licenses/lgpl-3.0.txt LGPL
 */

class PredictionGame {

	public $points;
	public $tips;
	public $results;
	
	public function __construct() {

		$this->points = array(
			3, // Exact result
			2, // Correct difference
			1, // Correct winner
			0  // nothing
		);

	}


	public function calcPoints() {

		$points = 0;

		if(is_array($this->tips) && is_array($this->results)) {

			foreach($this->tips AS $matchID => $matchResults) {

				if(isset($this->results[$matchID])) {
					$points += $this->compareResults($matchResults, $this->results[$matchID]);
				}

			}

		}

		return $points;

	}


	/* Array of Tips. Array keys should match the actual results.
	 * @param	Array	Tips, ([0] = Goals Hometeam, [1] = Goals Away team) 
	 *			Example array(0=>array(1,2), 1=>array(2,2), 2=>array(3,1)) means: 3 matches with the results 1:2, 2:2 and 3:1
	 * @return void
	 */
	public function setTips($tips=array()) {
		$this->tips = $tips;
		return $this;
	}


	/* Array of results. Keys should match the tips' keys.
	 * @param	Array	Tips, ([0] = Goals Hometeam, [1] = Goals Away team) 
	 *          Example array(0=>array(1,2), 1=>array(2,2), 2=>array(3,1)) means: 3 matches with the results 1:2, 2:2 and 3:1
	 * return void
	 */
	public function setResults($results=array()) {
		$this->results = $results;
		return $this;
	}


	/* Looks up which team won
	 * @param	Array	Result ([0] = Goals Hometeam, [1] = Goals Away team) 
	 * @return	Integer	0 = Draw, 1 = Victory home team, 2 = Victory away team
	 */
	public function getWinner($result) {

		if($result[0] > $result[1]) {
			return 1;
		} else if($result[1] > $result[0]) {
			return 2;
		} else if($result[0] == $result[1]) {
			return 0;
		}

		return $this;

	}


	/* Calculates the difference (always positive, so 1:3 is 2, not -2)
	 * @param	Array	Result ([0] = Goals Hometeam, [1] = Goals Away team) 
	 * @return	Integer	Difference
	 */
	public function getDifference($result) {

		if($result[0] > $result[1]) {
			return $result[0] - $result[1];
		} else if ($result[1] > $result[0]) {
			return $result[1] - $result[0];
		} else if($result[0] == $result[1]) {
			return 0;
		}

	}


	/* Compares two results and calculates the points according to the values of $this->points
	 * @param	Array	Result ([0] = Goals Hometeam, [1] = Goals Away team) 
	 * @param	Array	Result ([0] = Goals Hometeam, [1] = Goals Away team)
	 * @return	Integer	Points
	 *	               (Default: 3 = Exact match, 2 correct difference, 1 correct winner, 0 = nothing)
	 */
	public function compareResults($result1, $result2) {

		// Exact match
		if($result1[0] == $result2[0] && $result1[1] == $result2[1]) { 

			return $this->points[0];

		// Correct winner
		} else if($this->getWinner($result1) == $this->getWinner($result2)) { 

			// Both correct winner and correct difference
			if($this->getDifference($result1) == $this->getDifference($result2)) { 

				return $this->points[1];

			// Correct winner but difference was wrong
			} else { 

				return $this->points[2];

			}

		// Everything wrong
		} else { 

			return $this->points[3];

		}

	}

}

/*
// Usage:
$tip = new PredictionGame;
$tip->setTips(array(array(0, 2), array(3,1), array(1,1)))		// user predictions were: 0:2 (Match 1), 3:1 (Match 2), 1:1 (Match 3)
	->setResults(array(array(1, 3), array(0,1), array(1,1)));	// Actual results were: 1:3 (Match 1), 0:1 (Match 2), 1:1 (Match 3)
$points = $tip->calcPoints();
*/
