#extends Camera2D
#
#@export var player1: CharacterBody2D
#@export var player2: CharacterBody2D
#@export var transition_speed: float = 400.0
#@export var camera_switch_key: String = "ui_focus_next"
#
#var current_target: CharacterBody2D
#var is_transitioning: bool = false
#var path_points: Array[Vector2] = []
#var current_path_index: int = 0
#
#func _ready():
	#if player1 == null or player2 == null:
		#push_error("¡Error! Player1 o Player2 no están asignados en la cámara")
		#return
		#
	## Comenzar siguiendo al jugador 1
	#switch_to_player(player1)
	#position = current_target.position
#
#func _process(delta):
	#if current_target == null:
		#return
		#
	#if Input.is_action_just_pressed(camera_switch_key):
		#switch_target()
	#
	#if is_transitioning:
		#handle_transition(delta)
	#else:
		#position = current_target.position
#
#func switch_target():
	#if is_transitioning or player1 == null or player2 == null:
		#return
		#
	## Cambiar el objetivo
	#var new_target = player2 if current_target == player1 else player1
	#
	## Desactivar el jugador actual y activar el nuevo
	#switch_to_player(new_target)
	#
	## Calcular puntos de la trayectoria
	#calculate_path_points(current_target.position, new_target.position)
	#
	#is_transitioning = true
	#current_path_index = 0
#
#func switch_to_player(new_target: CharacterBody2D):
	## Desactivar el control del jugador actual
	#if current_target != null:
		#current_target.set_physics_process(false)
	#
	## Activar el control del nuevo jugador
	#current_target = new_target
	#current_target.set_physics_process(true)
#
#func calculate_path_points(start: Vector2, end: Vector2):
	#path_points.clear()
	#path_points.append(start)
	#
	#var mid_point = (start + end) / 2
	#var height_offset = 200
	#mid_point.y -= height_offset
	#path_points.append(mid_point)
	#
	#path_points.append(end)
#
#func handle_transition(delta):
	#if current_path_index >= path_points.size() - 1:
		#is_transitioning = false
		#return
	#
	#var target_pos = path_points[current_path_index + 1]
	#var direction = (target_pos - position).normalized()
	#var distance_to_next = position.distance_to(target_pos)
	#
	#if distance_to_next < 10:
		#current_path_index += 1
	#else:
		#position += direction * transition_speed * delta
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
