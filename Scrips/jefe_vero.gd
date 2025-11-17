extends Node2D

@onready var animacion_vero: AnimationPlayer = $AnimacionVero

func _ready() -> void:
	animacion_vero.play("ilde")
	
func _on_vida_vero_vida_termino() -> void:
	animacion_vero.play("muerte")

func _on_animacion_vero_animation_finished(anim_name: StringName) -> void:
	if anim_name == "muerte":
		queue_free()
