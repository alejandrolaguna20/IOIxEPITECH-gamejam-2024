extends CharacterBody2D

@export var speed = 80.0
@export var acceleration = 600.0
@export var is_starting_player = false  # Nueva variable para determinar el jugador inicial

@onready var animated_sprite = $AnimatedSprite2D
var last_direction = "down"

signal new_level

func _ready():
	# El jugador comenzará activo si es el jugador inicial
	set_physics_process(is_starting_player)

func _physics_process(delta):
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_up", "ui_down")
	input_dir = input_dir.normalized()
	
	if input_dir == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
	
	move_and_slide()
	handle_animations(input_dir)

func handle_animations(input_dir: Vector2):
	if input_dir != Vector2.ZERO:
		if abs(input_dir.x) > abs(input_dir.y):
			if input_dir.x > 0:
				play_animation("run_right")
				last_direction = "right"
			else:
				play_animation("run_left")
				last_direction = "left"
		else:
			if input_dir.y > 0:
				play_animation("run_down")
				last_direction = "down"
			else:
				play_animation("run_up")
				last_direction = "up"
	else:
		play_animation("idle_" + last_direction)

func play_animation(anim_name: String):
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)
		
		
		
func _on_change_level_body_entered(body: Node2D) -> void:
	print("entered change level")
	emit_signal("new_level")
