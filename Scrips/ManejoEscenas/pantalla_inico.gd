extends Control
class_name StartScreen 

func _on_button_button_up() -> void:
	ManejoEscenas._agregar_pantalla_carga()
	get_tree().call_deferred("change_scene_to_file","res://Escenas/Niveles/Buffet.tscn")
	


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		ManejoEscenas._agregar_pantalla_carga()
		get_tree().call_deferred("change_scene_to_file","res://Escenas/Niveles/Buffet.tscn")
		
