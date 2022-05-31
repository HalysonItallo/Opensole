extends Label

func update_score(point_scored: int):
	var score = int(text)
	score += point_scored
	text = str(score)
