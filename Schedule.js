function Schedule(teams) {

	me = this;
	this.matches = {};

	this.createMatchdayFixtures = function(matchday) {

		me.matches[matchday] = [];
		flip = (me.isFirstRound(matchday)) ? false : true; // If the matchday is in the second half, home and away team will be switched
		calcday = (me.isFirstRound(matchday)) ? matchday : matchday-(teams.length-1); // Matchday to be calculated with

		for(i = 1; i <teams.length; i++) {

			// TeamID < Matchday
			if(i < calcday) { 

				// Home team equals away team -> use wildcardteam instead
				if(i == calcday-i) { 

					// Hinrunde und Jokerteam hat Heimrecht (H: 8-16, A: 1-7/17)
					if (
						(flip === false && i >= (teams.length/2)-1 && i < teams.length-1 ) ||
						(flip === true && i >= 1 && i < (teams.length/2)-1) || // Second
						(flip === true && i == (teams.length-1)) // Second
					) {
						match = 0 + ':' + i;
						//match += '_1';
					} else if (
								(flip === false && i >= 1 && i < (teams.length/2)-1) || // First
								(flip === false && i == (teams.length-1)) || // First
								(flip === true && i >= (teams.length/2)-1 && i < teams.length-1 )
					) {
						match = i + ':' + 0;
						//match += '_2';
					}
					//matches[matchday].push(match);

				// Hometeam != Awayteam
				} else { 

					//if(calcday <= teams.length-1) { // Hinrunde

					if((i + (calcday-i)) %2 == 0) {	// Sum is even
						match = (
							(i > (calcday-i) && flip === false) ||
							(i < (calcday-i) && flip === true)
						) ? i + ':' + (calcday-i) : (calcday-i) + ':' + i;
						//match += '| _3 | ' + (calcday) + '|' + (calcday-i) + '|' + i + '|'+ (i > (calcday-i) && flip === false);
						//match += 'i: ' + i + ', calcday-i: ' + (calcday-i) + ', i>calcday:' + (i > (calcday-i)) + ', flip: ' + flip;
					} else {
						match = (
							(i > (calcday-i) && flip === false) ||
							(i < (calcday-i) && flip === true)
						) ? (calcday-i) + ':' + i : i + ':' + (calcday-i);
					}

				}


			} else if( i >= calcday) {

				for(j = teams.length-1; j>0; j--) {

					// Determine matches (team1 + team2 / total + 1, remainder should equal the matchday)
					if((i+j)%teams.length+1 == calcday) { 

						if(i != j) {

							if(calcday <= teams.length-1) { // First half

								if((i + j) %2 == 0) {	// sum is even

									if(
										(i > j && flip === false) ||
										(i < j && flip === true)
									) {
									// BUG?!
									match = i + ':' + j;
									//match += '_4';  
									} else {
										match = j + ':' + i;
										//match += '_3';
									}

								} else {

									if(
										(i < j && flip === false) ||
										(i > j && flip === true)
									) {
										match = i + ':' + j;
										//match += '_5';
									} else {
										match = j + ':' + i;
										//match += '_5b';
									}

								}

							}

						} else {

							if(calcday <= teams.length-1) { // First half

								if(
									(flip === false && i >= (teams.length/2)-1 && i < teams.length-1 ) ||
									(flip === true && i >= 1 && i < (teams.length/2)-1) || // Second
									(flip === true && i == (teams.length-1)) // Second
								) {
									match = 0 + ':' + i;
								} else {
									match = i + ':' + 0;
								}
							//	match += '_6';

							}

						}
				
					}

				}

			}

			me.matches[matchday][match] = match.split(':');

		}


	}

	// Match is in first half of the season?
	this.isFirstRound = function(matchday) {

		if(typeof teams != 'undefined') {

			if(matchday <= teams.length-1 && matchday > 0) {
				return true; // First half
			} else if(matchday >= teams.length && matchday < (teams.length-1)*2 ) {
				return false; // Second half
			}

		} else {
			throw new Exception('Unknown round error.');
		}

	}


	this.getSeasonFixtures = function() {

		for(var i = 1; i <= (teams.length-1)*2; i++) {

			me.createMatchdayFixtures(i);

		}

		return me.matches;

	}

}