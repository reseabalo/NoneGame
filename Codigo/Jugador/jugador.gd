extends CharacterBody2D
class_name  Jugador

@export var input_enabled:bool = true
@export var velocidad_movimiento : float = 230
var direccion_personaje : Vector2

const dash_velocidad = 525
var dashing = false
var can_dash = true

var can_atacar = true
var atacando = false
var puede_moverse = true

signal direccion_vista_cambio(viedo_derecha: bool)

func _physics_process(_delta):
	
	if not input_enabled:
		return 
	
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
		dashing = true
		can_dash = false
		$Timers/dash_tiempo.start()
		$Timers/dash_devuelta.start()
	

	if Input.is_action_just_pressed("Ataque") and can_atacar:
		atacando = true
		puede_moverse = false
		$Timers/ataque_tiempo.start()
		$Timers/dash_devuelta.start()
	
	if puede_moverse:
		if direccion_personaje:
			if dashing:
				velocity = direccion_personaje * dash_velocidad 
			else:
				velocity = direccion_personaje * velocidad_movimiento 
		else:
			velocity = velocity.move_toward(Vector2.ZERO,velocidad_movimiento)
	else:
		velocity = Vector2.ZERO
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
	

func _on_vida_vida_termino() -> void:
	#queue_free()
	#print(get_tree().get_current_scene().get_name())
	get_tree().reload_current_scene()



func enable():
	input_enabled = true
	visible = true
	
func disable():
	input_enabled = false
	
func orient(dir:Vector2):
	if dir.x:
		%AnimatedSprite2D.flip_h = dir.x < 0
