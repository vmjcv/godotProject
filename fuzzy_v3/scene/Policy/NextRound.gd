extends Button

func _on_NextRound_pressed():
	PolicyManage.end_round()
	PolicyManage.start_round()

