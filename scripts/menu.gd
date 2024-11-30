extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	await ready
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
