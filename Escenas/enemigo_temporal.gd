extends Node2D

@onready var vida_enemigo: Vida = $Vida_enemigo
var vivo: bool = true

var datos_a_guardar: Dictionary = {
	"posicion_enemigo_x": null,
	"posicion_enemigo_y": null,
	"vida_enemigo": null,
	"escena":null
}

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

func _on_vida_enemigo_vida_termino() -> void:
	vivo = false
	get_parent().call_deferred("remove_child",self)
	queue_free()
