class_name StartScreen extends Control

func _on_button_button_up() -> void:

	ManejoEscenas.swap_scenes("res://escenas/CambioEscena/gameplay.tscn",get_tree().root,self,"ir_oscurecer")
	


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		ManejoEscenas.swap_scenes("res://escenas/CambioEscena/gameplay.tscn",get_tree().root,self,"ir_oscurecer")
		
