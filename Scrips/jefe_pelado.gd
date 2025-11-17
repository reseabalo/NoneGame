extends Node2D

@onready var animacion_pelado: AnimationPlayer = $AnimacionPelado
@onready var timer: Timer = $Timer


func _ready() -> void:
	animacion_pelado.play("ilde")
	timer.start()
	
func _on_vida_pelado_vida_termino() -> void:
	timer.stop()
	animacion_pelado.play("muerte")
	
func _on_timer_timeout() -> void:
	animacion_pelado.play("enojado")
	timer.start()

func _on_animacion_pelado_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enojado":
		animacion_pelado.play("ilde")
	
	if anim_name == "muerte":
		queue_free()
	
