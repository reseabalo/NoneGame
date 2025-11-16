extends Node2D
class_name  RaizMundo

@onready var jugador: Jugador = %Jugador
@onready var jugador_2: Jugador = %"Jugador 2"

var lista: Array
var jugador_seleccionado : Jugador

var datos_guardar: Dictionary = {
	"posicion_jugador_x": null,
	"posicion_jugador_y": null,
	"vida_jugador": null,
	"jugador_seleccionado": null,
	"jugador_seleccionado_escena": null
}

#ready por el momento
#ve si algun true en la lista que se le es pasada
#si no hay ninguno no entrara a la funcion en_seleccion_personaje 
func _ready() -> void:
	
	var lista_temp: Array
	lista_temp = ManejoEscenas.get_seleccionar_personaje()
	var con: int = 0
	
	for lis in lista:
		if lis == false:
			con += 1
	
	if con < 2:
		en_seleccion_de_personaje(lista_temp)

func cargar_nivel_async(direccion: String):
	await get_tree().physics_frame
	get_tree().paused = true 
	
	for node in get_tree().get_nodes_in_group("nivel"):
		ManejoEscenas.set_escena_actual(get_direccion_nivel_actual())
	
	var puerta_salida = ManejoEscenas.get_nombre_puerta()
	var siguente_nivel = load(direccion).instantiate()
	
	#saca y lobera de la memoria los nodos del nivel anterior 
	#en este caso mantiene al los nodes del grupo jugador dentro del arbol
	for child in get_children():
		if not child.is_in_group("Jugador"):
			remove_child(child)
			child.queue_free()
	
	add_child(siguente_nivel)
	
	#mueve al frente a los nodos del grupo jugador para que se dibujen primero
	for child in get_children():
		if child.is_in_group("Jugador"):
			child.move_to_front()
	
	if puerta_salida != "":
		get_tree().call_group("Puertas","puerta_a_salir",ManejoEscenas.get_nombre_puerta(),jugador_seleccionado)
		
	get_tree().paused = false
	

#funcion que guarda en una lista temporal el jugador elegido
#y saca de memoria al jugador que no fue elegido
func en_seleccion_de_personaje(lis:Array):
	
	var jugable_1: bool
	var jugable_2: bool	
	
	lista = lis
	jugable_1 = lis[0]
	jugable_2 = lis[1]
	
	if jugable_1:
		remove_child(jugador_2)
		jugador_2.queue_free()
		jugador_seleccionado = jugador
		return
	
	if jugable_2:
		remove_child(jugador)
		jugador.queue_free()
		jugador_seleccionado = jugador_2
		return
		

#funcion que guarda la direccion de los niveles que esta en el grupo nivel
# de esta forma no habra problemas a la hora de cambiar de carpeta un nivel
func get_direccion_nivel_actual():
	
	for node in get_tree().get_nodes_in_group("nivel"):
		return node.scene_file_path
	
	push_error("actualmente no hay ningun nivel cargado")
	return "res://invalido.tscn"	

func en_guardado_partida(lista_datos: Array):
	var jugable: int = -1
	var con: int = 0
	
	while jugable == -1:
		if lista[con]:
			jugable = con
	
	match jugable:
		0: 
			datos_guardar["posicion_jugador_x"] = jugador.global_position.x
			datos_guardar["posicion_jugador_y"] = jugador.global_position.y
			datos_guardar["vida_jugador"] = jugador.vida.get_vida()
			datos_guardar["jugador_seleccionado"] = jugable+1
			datos_guardar["jugador_seleccionado_escena"] = jugador.scene_file_path
			lista_datos.append(datos_guardar)
		1:
			datos_guardar["posicion_jugador_x"] = jugador_2.global_position.x
			datos_guardar["posicion_jugador_y"] = jugador_2.global_position.y
			datos_guardar["vida_jugador"] = jugador_2.vida.get_vida()
			datos_guardar["jugador_seleccionado"] = jugable+1
			datos_guardar["jugador_seleccionado_escena"] = jugador_2.scene_file_path
			lista_datos.append(datos_guardar)

func en_cargado_partida(datos_guardados: Array):
	var jugable: int
	var dato_cargar: Dictionary
	
	
	for dato in datos_guardados:
		if dato.has("posicion_jugador_x"):
			dato_cargar = dato
			break
	jugable = dato_cargar["jugador_seleccionado"]	
	
	match jugable:
		1:
			jugador.global_position.x = dato_cargar["posicion_jugador_x"]
			jugador.global_position.y = dato_cargar["posicion_jugador_y"]
			jugador.vida.set_vida(dato_cargar["vida_jugador"])
			lista = [true,false]
			remove_child(jugador_2)
			jugador_2.queue_free()
			jugador_seleccionado = jugador
		2:
			jugador_2.global_position.x = dato_cargar["posicion_jugador_x"]
			jugador_2.global_position.y = dato_cargar["posicion_jugador_y"]
			jugador_2.vida.set_vida(dato_cargar["vida_jugador"])
			lista = [false,true]
			remove_child(jugador)
			jugador.queue_free()
			jugador_seleccionado = jugador_2

func restauracion_enemigo(restaurado: Object):
	add_child(restaurado)
	
func en_muerte():
	var ciclo : bool = true
	var cont : int = 0
	var datos_temporales: String = "user://TemporalNivel" + str(cont) +".json"
	 
	while ciclo:
		if FileAccess.file_exists(datos_temporales):
			DirAccess.remove_absolute(datos_temporales)
			cont += 1
			datos_temporales = "user://TemporalNivel" + str(cont) +".json"
		else:
			ciclo = false
