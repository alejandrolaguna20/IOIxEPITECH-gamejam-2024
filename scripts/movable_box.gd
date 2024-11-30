extends CharacterBody2D

func _ready():
	# Connect the body_entered signal from the Area2D to our _on_body_entered method
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))
