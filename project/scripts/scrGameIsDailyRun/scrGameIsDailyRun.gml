function scrGameIsEventRun() {
	// Challenges are disabled for the NTTE edition.
	return false
}

function scrGameIsDailyRun() {
	return false
}

function scrGameIsWeeklyRun() {
	return false
}

function scrGameIsHardmode() {
	return UberCont.hardmode
}

function scrGameIsContinuedRun() {
	return UberCont.continued_run
}

function scrGameIsCustomMode() {
	return UberCont.custom
}


