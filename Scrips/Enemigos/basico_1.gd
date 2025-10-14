extends enemigo
class_name basico_1

@export var ataque_direccion : ataques_direccion
var speed = 50.0
var siguiente_perseguir = false

var facing_right = true
var player : Jugador = null
var direction:Vector2
enum Estado {idle, atacar, persiguiendo, recargando, muerto, intermedio}
var estado = Estado.idle


func _physics_process(_delta):
	if estado == Estado.muerto:
		morir()
	elif estado == Estado.idle:
		descansar()
	elif estado == Estado.persiguiendo:
		perseguir()
	elif estado == Estado.recargando:
		recargando()
	elif estado == Estado.atacar:
		attack()

func morir():
	$AnimationPlayer.play("muerte")
	$muerte.start()
	estado = Estado.intermedio

func descansar():
	$AnimationPlayer.play("idle")

func perseguir():
	direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	$AnimationPlayer.play("caminar")
	move_and_slide()
	facing(direction)

@warning_ignore("shadowed_variable")
func facing(direction):
	if direction.x <0:
		facing_right=false
		$Sprite2D.flip_h = true
		
	else:
		facing_right=true
		$Sprite2D.flip_h = false
		

func attack():
	estado = Estado.intermedio
	$AnimationPlayer.play("ataque")
	$ataque_duracion.start()

func recargando():
	estado = Estado.intermedio
	$AnimationPlayer.play("recargando")
	$ataque_cd.start()

func _on_area_deteccion_body_entered(_body: Jugador) -> void:
	player = _body
	estado = Estado.persiguiendo

func _on_area_deteccion_body_exited(_body: Jugador) -> void:
	estado = Estado.idle

func _on_area_ataque_body_entered(_body: Jugador) -> void:
	siguiente_perseguir = false
	if estado != Estado.intermedio:
		estado = Estado.atacar

func _on_area_ataque_body_exited(_body: Jugador) -> void:
	siguiente_perseguir = true

func _on_ataque_duracion_timeout() -> void:
	estado = Estado.recargando


func _on_ataque_cd_timeout() -> void:
	if siguiente_perseguir:
		siguiente_perseguir = false
		estado = Estado.persiguiendo
	else:
		estado = Estado.atacar
	

func _on_vida_enemigo_vida_termino() -> void:
	print("Muerto!")
	estado = Estado.muerto



func _on_muerte_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
