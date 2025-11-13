/datum/patron/faerun
	name = null
	associated_faith = /datum/faith/faerun/neutral_gods
	preference_accessible = TRUE

/datum/patron/faerun/neutral_gods
	name = null
	associated_faith = /datum/faith/faerun/neutral_gods
	profane_words = list()

/datum/patron/faerun/neutral_gods/testneutral
	name = "Test Neutral"
	domain = "Test domain"
	desc = "What makes a man turn neutral? A lust for gold? Power? Or were you just born with a heart full of neutrality?"
	flaws = "Gray, neutral"
	worshippers = "Truly Uncaring"
	sins = "Desire"
	boons = "True Neutrality."

	confess_lines = list(
		"NO STRONG FEELINGS ONE WAY OR THE OTHER!"
	)

/datum/patron/faerun/neutral_gods/ao
	name = "Ao"
	domain = "Everything"
	desc = "The Overgod."
	flaws = "-"
	worshippers = "-"
	sins = "-"
	boons = "-"

	confess_lines = list(
		"AO!"
	)
