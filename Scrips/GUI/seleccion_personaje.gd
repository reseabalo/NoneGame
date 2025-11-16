extends Node2D

@onready var cinematica_inicio_partida: VideoStreamPlayer = $CanvasLayer/CinematicaInicioPartida
@onready var botones_seleccion: HBoxContainer = $CanvasLayer/BotonesSeleccion

var personaje_1: bool
var personaje_2: bool

func _ready() -> void:
	cinematica_inicio_partida.visible = false

func _on_maria_pressed() -> void:
	personaje_1 = true
	personaje_2 = false
	borrar_archivos_temporrales()
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	cinematica_inicio_partida.visible = true
	botones_seleccion.visible = false
	cinematica_inicio_partida.play()

func _on_jere_pressed() -> void:
	personaje_1 = false
	personaje_2 = true
	borrar_archivos_temporrales()
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	cinematica_inicio_partida.visible = true
	botones_seleccion.visible = false
	cinematica_inicio_partida.play()

func borrar_archivos_temporrales():
	var loop : bool = true
	var cont : int = 0
	var datos_temporales: String = "user://TemporalNivel" + str(cont) +".json"
	 
	while loop:
		if FileAccess.file_exists(datos_temporales):
			DirAccess.remove_absolute(datos_temporales)
			cont += 1
			datos_temporales = "user://TemporalNivel" + str(cont) +".json"
		else:
			loop = false


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		cinematica_inicio_partida.stop()
		cinematica_inicio_partida.emit_signal("finished")

func _on_cinematica_inicio_partida_finished() -> void:
	ManejoEscenas.transicion("ir_oscurecer")
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")
