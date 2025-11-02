extends enemigo
class_name basico_1

@export var ataque_direccion : ataques_direccion
var speed = 50.0


var facing_right = false
var player : Jugador = null
var direction:Vector2
enum Estado {idle, atacando, persiguiendo, recargando, muerto, intermedio, indeciso}
var estado = Estado.idle
enum Siguiente_estado {idle, atacando, persiguiendo, inicio}
var sig_estado =  Siguiente_estado.inicio

func _physics_process(_delta):
	if estado == Estado.indeciso:
		determinar_siguiente_estado()
	else:
		determinar_accion()



func determinar_accion ():
	if estado == Estado.muerto:
		morir()
	elif estado == Estado.intermedio:
		pass
	elif estado == Estado.recargando:
		estado = Estado.intermedio
		recargar()
	elif estado == Estado.atacando:
		estado = Estado.intermedio
		atacar()
	elif estado == Estado.idle:
		descansar()
	elif estado == Estado.persiguiendo:
		if not $AnimationPlayer.current_animation == "ataque":
			perseguir()
			estado = Estado.indeciso

func determinar_siguiente_estado ():
	if sig_estado == Siguiente_estado.idle:
		estado = Estado.idle
	elif sig_estado == Siguiente_estado.persiguiendo:
		estado = Estado.persiguiendo
	elif sig_estado == Siguiente_estado.atacando:
		estado = Estado.atacando

func morir():
	estado = Estado.intermedio
	$AnimationPlayer.stop()
	$AnimationPlayer.play("muerte")
	$muerte.start()

func descansar():
	$AnimationPlayer.play("idle")
	estado = Estado.indeciso

func perseguir():
	$AnimationPlayer.play("caminar")
	direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	facing(direction)
	move_and_slide()

@warning_ignore("shadowed_variable")
func facing(direction):
	if direction.x > 0:
		facing_right=true
		$Sprite2D.flip_h = true
		
	else:
		facing_right=false
		$Sprite2D.flip_h = false
		

func atacar():
	$AnimationPlayer.play("ataque")
	$ataque_duracion.start()

func recargar():
	$AnimationPlayer.play("recargando")
	$ataque_cd.start()

func _on_area_deteccion_body_entered(body: Jugador) -> void:
	player = body
	sig_estado = Siguiente_estado.persiguiendo

func _on_area_deteccion_body_exited(_body: Jugador) -> void:
	sig_estado = Siguiente_estado.idle

func _on_area_ataque_body_entered(_body: Jugador) -> void:
	sig_estado = Siguiente_estado.atacando

func _on_area_ataque_body_exited(_body: Jugador) -> void:
	sig_estado = Siguiente_estado.persiguiendo

func _on_ataque_duracion_timeout() -> void:
	estado = Estado.recargando


func _on_ataque_cd_timeout() -> void:
	estado = Estado.indeciso
	

func _on_vida_enemigo_vida_termino() -> void:
	estado = Estado.muerto



func _on_muerte_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
