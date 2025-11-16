extends Node2D

@onready var musica_menu: AudioStreamPlayer = $"Musica Menu"
@onready var cinematica_inicio: VideoStreamPlayer = $CanvasLayer/CinematicaInicio
@onready var contenedor_botones: VBoxContainer = $CanvasLayer/ContenedorBotones

#se encarga se settear los cambios que hallas hecho en el menu de opciones
func _ready() -> void:
	cinematica_inicio.play()
	contenedor_botones.visible = false
	GUI.calculate_window_size()
	GUI.set_modo_pantalla()
	GUI.redimencionar_ventana()
	GUI.visibilidad = false

		
#inicia en la escena del comienzo del juego
func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/seleccion_personaje.tscn")

func _on_cargar_partida_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/cargar_Partida.tscn")

#va a la escena del menu de obciones
func _on_opciones_pressed() -> void:
	ManejoEscenas.transicion("ir_oscurecer")
	get_tree().change_scene_to_file("res://Escenas/GUI/Menu Opciones.tscn")

#salir del juego
func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_cinematica_inicio_finished() -> void:
	contenedor_botones.visible = true
	contenedor_botones.move_to_front()
	musica_menu.play()
	musica_menu.autoplay = true

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_pressed():
		cinematica_inicio.stop()
		cinematica_inicio.emit_signal("finished")
	
