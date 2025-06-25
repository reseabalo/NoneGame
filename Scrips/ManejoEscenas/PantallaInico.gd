extends Node2D

@onready var cinematica_apertura: VideoStreamPlayer = $"CanvasLayer/Cinematica Apertura"
@onready var musica_menu: AudioStreamPlayer = $"Musica Menu"


#se encarga se settear los cambios que hallas hecho en el menu de opciones
func _ready() -> void:
	GUI.calculate_window_size()
	GUI.set_modo_pantalla()
	GUI.redimencionar_ventana()
	GUI.visibilidad = false
	if Input.is_action_just_pressed("enter"):
		cinematica_apertura.autoplay = false
		cinematica_apertura.visible = false
		cinematica_apertura.stop()


		
#inicia en la escena del comienzo del juego
func _on_jugar_pressed() -> void:
	ManejoEscenas.ir_a_nivel("res://Escenas/Niveles/Buffet.tscn","","ir_oscurecer")

#va a la escena del menu de obciones
func _on_opciones_pressed() -> void:
	ManejoEscenas.ir_a_escena("res://Escenas/GUI/menu_opciones.tscn","ir_oscurecer","res://Escenas/ManejoEscenas/pantalla_inico.tscn")

#salir del juego
func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_cinematica_apertura_finished() -> void:
	cinematica_apertura.visible = false
	musica_menu.play()
