extends CharacterBody2D

@export var speed = 300.0
@export var acceleration = 1500.0

@onready var animated_sprite = $AnimatedSprite2D

# La última dirección que miró el personaje (para el idle)
var last_direction = "down"

func _ready():
	# Asegurarse de que empezamos en idle
	play_animation("idle_" + last_direction)

func _physics_process(delta):
	# Obtener input
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_up", "ui_down")
	input_dir = input_dir.normalized()
	
	# Manejar movimiento
	if input_dir == Vector2.ZERO:
		# Desacelerar cuando no hay input
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		# Acelerar hacia la dirección del input
		velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
	
	move_and_slide()
	
	# Manejar animaciones
	handle_animations(input_dir)

func handle_animations(input_dir: Vector2):
	if input_dir != Vector2.ZERO:
		# Determinar la dirección dominante
		if abs(input_dir.x) > abs(input_dir.y):
			# Movimiento horizontal
			if input_dir.x > 0:
				play_animation("run_right")
				last_direction = "right"
			else:
				play_animation("run_left")
				last_direction = "left"
		else:
			# Movimiento vertical
			if input_dir.y > 0:
				play_animation("run_down")
				last_direction = "down"
			else:
				play_animation("run_up")
				last_direction = "up"
	else:
		# Cuando no hay movimiento, usar la última dirección para el idle
		play_animation("idle_" + last_direction)

func play_animation(anim_name: String):
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)
