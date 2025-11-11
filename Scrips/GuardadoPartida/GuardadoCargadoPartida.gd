extends Node

@onready var raiz_mundo: RaizMundo = %RaizMundo

var datos: Dictionary = {
	"direccion_nivel": null,
}

var lista_datos: Array

const PartidaUnoDireccion : String =  "user://PartidaUno.json"

func guardar_partida():
	var archivo = FileAccess.open(PartidaUnoDireccion,FileAccess.WRITE)
	lista_datos.clear()
	
	datos["direccion_nivel"] = raiz_mundo.get_direccion_nivel_actual()
	lista_datos.append(datos)
	
	get_tree().call_group("eventos_juego","en_guardado_partida",lista_datos)
	
	var json = JSON.stringify(lista_datos)
	
	archivo.store_string(json)
	archivo.close()
	
func cargar_partida():
	var dato_cargar:Dictionary
	var archivo = FileAccess.open(PartidaUnoDireccion,FileAccess.READ)
	
	var json = archivo.get_as_text()
	var datos_guardados = JSON.parse_string(json)
		
	for dato in datos_guardados:
		if dato.has("direccion_nivel"):
			dato_cargar = dato
			break
	
	await raiz_mundo.cargar_nivel_async(dato_cargar["direccion_nivel"])
	
	get_tree().call_group("eventos_juego","antes_cargar_partida")
	
	for dato in datos_guardados:
		if dato.has("escena"):
			var escena := load(dato["escena"]) as PackedScene
			var nodo_restaurado = escena.instantiate()
			
			raiz_mundo.add_child(nodo_restaurado)
			
			if nodo_restaurado.has_method("en_cargado_partida"):
				nodo_restaurado.en_cargado_partida(dato)
	
	get_tree().call_group("Jugador","en_cargado_partida",datos_guardados)
	
	ManejoEscenas.terminar_transicion()
	archivo.close()


#usado para cargar el momento en el que el jugador sale del menu de opciones
# a haber entrado desde el menu de pausa a este
func cargardo_del_momento(guardado_momento: String):
	var archivo = FileAccess.open(guardado_momento,FileAccess.READ)
	
	var json = archivo.get_as_text()
	var datos_guardados = JSON.parse_string(json)
	
	if ManejoEscenas.get_salio_menu():
		await raiz_mundo.cargar_nivel_async(ManejoEscenas.get_escena_actual())
		ManejoEscenas.set_salio_menu(false)
	
	get_tree().call_group("enemigo","antes_cargar_partida")
	
	for dato in datos_guardados:
		if dato.has("escena"):
			var escena := load(dato["escena"]) as PackedScene
			var nodo_restaurado = escena.instantiate()
			
			raiz_mundo.add_child(nodo_restaurado)
			
			if nodo_restaurado.has_method("en_cargado_partida"):
				nodo_restaurado.en_cargado_partida(dato)
	
	archivo.close()

func guardado_del_momento(guardado_momento: String):
	var archivo = FileAccess.open(guardado_momento,FileAccess.WRITE)
	lista_datos.clear()
	
	datos["direccion_nivel"] = raiz_mundo.get_direccion_nivel_actual()
	lista_datos.append(datos)
	
	get_tree().call_group("enemigo","en_guardado_partida",lista_datos)
	
	var json = JSON.stringify(lista_datos)

	archivo.store_string(json)
	archivo.close()
