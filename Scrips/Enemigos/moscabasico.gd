extends enemigo
class_name basico_2

@onready var vida_enemigo: Vida = $Vida_enemigo
var vivo: bool = true

var datos_a_guardar: Dictionary = {
	"posicion_enemigo_x": null,
	"posicion_enemigo_y": null,
	"vida_enemigo": null,
	"escena":null
}

var speed = 25.0
var siguiente_ataque = false
var atk_derecha : bool

var escena_bala = preload("res://Escenas/Enemigos/bala.tscn")

var facing_right = true
var player : Jugador = null
var direction:Vector2
enum Estado {idle, atacar, huyendo, recargando, muerto, intermedio}
var estado = Estado.idle


func _physics_process(_delta):
	if estado == Estado.muerto:
		morir()
	elif estado == Estado.idle:
		descansar()
	elif estado == Estado.huyendo:
		huir()
	elif estado == Estado.atacar:
		attack()

func morir():
	$ataque_cd.stop()
	$ataque_duracion.stop()
	$AnimationPlayer.play("muerte")
	$muerte.start()
	estado = Estado.intermedio

func descansar():
	$AnimationPlayer.play("idle")
	$ataque_cd.stop()
	siguiente_ataque = false

func huir():
	if not siguiente_ataque:
		$ataque_cd.start()
		siguiente_ataque = true
	direction = (global_position - player.global_position).normalized()
	velocity = direction * speed
	$AnimationPlayer.play("caminar")
	move_and_slide()
	facing(direction)

@warning_ignore("shadowed_variable")
func facing(direction):
	if direction.x > 0:
		facing_right=false
		$Sprite2D.flip_h = true
		
	else:
		facing_right=true
		$Sprite2D.flip_h = false
		

func attack():
	if direction.x > 0:
		$Sprite2D.flip_h = false
		atk_derecha = false
		$Marker2D.position.x = -26
	else:
		$Sprite2D.flip_h = true
		atk_derecha = true
		$Marker2D.position.x = 26
	estado = Estado.intermedio
	$AnimationPlayer.play("ataque")
	$ataque_duracion.start()
	$disparo.start()

func _on_area_deteccion_body_entered(body: Jugador):
	player = body
	estado = Estado.huyendo

func _on_area_deteccion_body_exited(_body: Jugador) -> void:
	estado = Estado.idle

func _on_ataque_duracion_timeout() -> void:
	estado = Estado.huyendo
	siguiente_ataque = false

func _on_ataque_cd_timeout() -> void:
	estado = Estado.atacar

func _on_vida_enemigo_vida_termino() -> void:
	estado = Estado.muerto

func _on_muerte_timeout() -> void:
	vivo = false
	get_parent().remove_child(self)
	queue_free()

func _on_disparo_timeout() -> void:
	var b = escena_bala.instantiate()
	get_tree().root.add_child(b)
	b.start($Marker2D.global_position)
	b.apuntar((global_position - player.global_position).normalized())

func en_guardado_partida(lista_guardar: Array):
	if vivo == false:
		return
		
	datos_a_guardar["posicion_enemigo_x"] = global_position.x
	datos_a_guardar["posicion_enemigo_y"] = global_position.y
	datos_a_guardar["vida_enemigo"] = vida_enemigo.get_vida()
	datos_a_guardar["escena"] = scene_file_path
	
	lista_guardar.append(datos_a_guardar)

func antes_cargar_partida():
	get_parent().call_deferred("remove_child",self)
	queue_free()

func en_cargado_partida(datos_guardados: Dictionary):

		global_position.x = datos_guardados["posicion_enemigo_x"]
		global_position.y = datos_guardados["posicion_enemigo_y"]
		vida_enemigo.set_vida(datos_guardados["vida_enemigo"])  
