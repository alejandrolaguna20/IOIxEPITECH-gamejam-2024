extends Control

@onready var world = $"../../"

func _on_resume_pressed() -> void:
	world.pauseMenu()
	





func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
