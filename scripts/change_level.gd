# Area2D Script
extends Area2D

@export var target_scene: String = "" 

signal new_level
signal change_level(extra_arg_0: String)

func _on_body_entered(body: Node) -> void:
	emit_signal("change_level", "Level_2")

func _on_player_green_new_level() -> void:
	get_tree().change_scene_to_file("res://scenes/" + target_scene + ".tscn")

func _on_player_blue_new_level() -> void:
	get_tree().change_scene_to_file("res://scenes/" + target_scene + ".tscn")
