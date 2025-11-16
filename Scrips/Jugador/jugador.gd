extends CharacterBody2D
class_name Jugador

@export var velocidad_movimiento : float = 230
var direccion_personaje : Vector2
@onready var vida: Vida = %Vida
@onready var muerte: Timer = $Timers/Muerte

const dash_velocidad = 525
var dashing = false
var can_dash = true
var can_atacar = true
var atacando = false
var puede_moverse = true
var vivo = true

signal direccion_vista_cambio(direccion: Vector2 )


func _physics_process(_delta):
	
	direccion_personaje.x = Input.get_axis("mover_izquierda","mover_derecha")
	direccion_personaje.y = Input.get_axis("mover_arriba","mover_abajo")
	direccion_personaje = direccion_personaje.normalized()
	
	#flip
	if direccion_personaje.x > 0:
		%AnimatedSprite2D.flip_h = false
	elif direccion_personaje.x < 0: 
		%AnimatedSprite2D.flip_h = true
		
	emit_signal("direccion_vista_cambio",direccion_personaje)
	
	if Input.is_action_just_pressed("desplazamiento") and can_dash:
		dashing = true
		can_dash = false
		$Timers/dash_tiempo.start()
		$Timers/dash_devuelta.start()
	

	if Input.is_action_just_pressed("ataque") and can_atacar:
		atacando = true
		puede_moverse = false
		$Timers/ataque_tiempo.start()
		$Timers/dash_devuelta.start()
	
	if !puede_moverse:
		velocity = Vector2.ZERO
		
	if direccion_personaje and puede_moverse:
		if dashing:
			velocity = direccion_personaje * dash_velocidad 
		else:
			velocity = direccion_personaje * velocidad_movimiento 
	else:
		velocity = velocity.move_toward(Vector2.ZERO,velocidad_movimiento)

	move_and_slide()

#para parar el dash
func _on_dash_tiempo_timeout():
	dashing = false

func _on_dash_devuelta_timeout():
	can_dash = true

#tiepo entre ataques
func _on_ataque_tiempo_timeout():
	atacando = false
	puede_moverse = true

func _on_ataque_devuelta_timeout():
	can_atacar = true
	
func _on_spawn(posicion: Vector2, _direccion: String):
	global_position = posicion

func _on_vida_vida_termino() -> void:
	vivo = false
	muerte.start()

func no_permitir_movimiento():
	puede_moverse = false

func permitir_movimiento():
	puede_moverse = true

#hardcodeado por lo tanto esto es temporal 
func _on_muerte_timeout() -> void:
	ManejoEscenas.transicion("ir_oscurecer")
	get_tree().call_group("eventos_juego","en_muerte")
	get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/Niveles/buffet.tscn")
	global_position = Vector2(1107,391)
	vida.set_vida(vida.get_vida_maxima())
	vivo = true
	muerte.stop()
	ManejoEscenas.terminar_transicion()
	
