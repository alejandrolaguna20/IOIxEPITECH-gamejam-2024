extends Camera2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var transition_speed: float = 400.0
@export var camera_switch_key: String = "ui_focus_next"

var current_target: CharacterBody2D
var is_transitioning: bool = false
var target_position: Vector2

func _ready():
	if player1 == null or player2 == null:
		push_error("¡Error! Player1 o Player2 no están asignados en la cámara")
		return
		
	switch_to_player(player1)
	position = current_target.position

func _process(delta):
	if current_target == null:
		return
		
	if Input.is_action_just_pressed(camera_switch_key):
		switch_target()
	
	if is_transitioning:
		handle_transition(delta)
	else:
		position = current_target.position

func switch_target():
	if is_transitioning or player1 == null or player2 == null:
		return
		
	# Cambiar el objetivo
	var new_target = player2 if current_target == player1 else player1
	
	# Guardar la posición objetivo
	target_position = new_target.position
	
	# Desactivar el jugador actual y activar el nuevo
	switch_to_player(new_target)
	
	is_transitioning = true

func switch_to_player(new_target: CharacterBody2D):
	if current_target != null:
		current_target.set_physics_process(false)
	
	current_target = new_target
	current_target.set_physics_process(true)

func handle_transition(delta):
	# Calcular la distancia al objetivo
	var distance_to_target = position.distance_to(target_position)
	
	if distance_to_target < 10:
		# Si estamos lo suficientemente cerca, terminamos la transición
		is_transitioning = false
		position = target_position
	else:
		# Movernos en línea recta hacia el objetivo
		var direction = (target_position - position).normalized()
		position += direction * transition_speed * delta
