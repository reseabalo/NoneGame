extends CharacterBody2D
class_name Jugador

@export var velocidad_movimiento : float = 230
var direccion_personaje : Vector2
@onready var vida: Vida = %Vida

const  dash_velocidad = 1000
var dashing = false
var can_dash = true
var can_atacar = true
var atacando = false
var puede_moverse = true
var ultima_direccion_movimiento :Vector2= Vector2(1.0,0.0)

signal direccion_vista_cambio(viedo_derecha: bool)

func _ready() -> void:
	ManejoEscenas.trigger_en_el_spawn_jugador.connect(_on_spawn)
	if ManejoEscenas.get_dato() > 0:
		ManejoEscenas.escena_cambio.connect(_cambiar_vida)


func _physics_process(_delta):
	
	direccion_personaje.x = Input.get_axis("mover_izquierda","mover_derecha")
	direccion_personaje.y = Input.get_axis("mover_arriba","mover_abajo")
	direccion_personaje = direccion_personaje.normalized()
	
	#flip
	if direccion_personaje.x > 0:
		%AnimatedSprite2D.flip_h = false
	elif direccion_personaje.x < 0: 
		%AnimatedSprite2D.flip_h = true
		
	emit_signal("direccion_vista_cambio",!%AnimatedSprite2D.flip_h)
	
	if Input.is_action_just_pressed("dash") and can_dash:
		velocity = ultima_direccion_movimiento * dash_velocidad
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
		
	if direccion_personaje and puede_moverse and dashing == false:
		ultima_direccion_movimiento = direccion_personaje
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
	queue_free()
	ManejoEscenas.transicion("ir_oscurecer")
	get_tree().call_deferred("reload_current_scene")
	%Vida.set_vida(5)
	
func _cambiar_vida(diff: int):
	%Vida.set_vida(diff)

func _on_vida_vida_cambio(_diff: int) -> void:
	ManejoEscenas.set_dato(%Vida.get_vida())
