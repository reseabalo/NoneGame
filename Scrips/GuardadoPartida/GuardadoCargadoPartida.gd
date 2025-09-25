extends Node

@onready var raiz_mundo: RaizMundo = %RaizMundo

var datos: Dictionary = {
	"direccion_nivel": null,
	"posicion_jugador_x": null,
	"posicion_jugador_y": null,
	"vida_jugador": null,
	"jugador_seleccionado": null,
	"jugador_seleccionado_escena": null
}

var PartidaUnoDireccion : String =  "user://PartidaUno.json"

func guardar_partida():
	var archivo = FileAccess.open(PartidaUnoDireccion,FileAccess.WRITE)
	
	datos["direccion_nivel"] = raiz_mundo.get_direccion_nivel_actual()
	
	get_tree().call_group("eventos_juego","en_guardado_partida",datos)
	
	var json = JSON.stringify(datos)
	
	archivo.store_string(json)
	archivo.close()
	
func cargar_partida():
	var archivo = FileAccess.open(PartidaUnoDireccion,FileAccess.READ)
	
	var json = archivo.get_as_text()
	var datos_guardados = JSON.parse_string(json)
	
	await raiz_mundo.cargar_nivel_async(datos_guardados["direccion_nivel"])
	
	get_tree().call_group("eventos_juego","antes_cargar_partida",datos_guardados)
	
	#var escena := load(datos_guardados["jugador_seleccionado_escena"]) as PackedScene
	#var nodo_restaurado = escena.instantiate()
	#raiz_mundo.add_child(nodo_restaurado)
	get_tree().call_group("eventos_juego","en_cargado_partida",datos_guardados)
	ManejoEscenas.terminar_transicion()
	archivo.close()
