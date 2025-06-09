extends Node

@export var animation_tree : AnimationTree
@export var juga : Jugador
@export var cambio_colisiones : CambioColisiones2D
@onready var jugador: Jugador = get_owner()

func _ready() -> void:
	juga.connect("direccion_vista_cambio", _on_jugador_viendo_direccion_cambio)


var ultima_direccion_vista := Vector2 (0,-1)

func _physics_process(_delta: float) -> void:
	
	var ilde = !jugador.direccion_personaje
	
	if !ilde:
		ultima_direccion_vista = jugador.direccion_personaje.normalized()
	
	animation_tree.set("parameters/caminata",ultima_direccion_vista)
	animation_tree.set("parameters/ilde",ultima_direccion_vista)
	animation_tree.set("parameters/ataque",ultima_direccion_vista)
	
func _on_jugador_viendo_direccion_cambio(viendo_derecha: bool):
	if (viendo_derecha):
		cambio_colisiones.position = cambio_colisiones.viendo_posicion_derecha
	else:
		cambio_colisiones.position = cambio_colisiones.viendo_posiocion_izquierda
	
