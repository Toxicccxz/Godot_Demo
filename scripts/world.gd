extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scenes()


func _on_cliffside_transition_point_body_entered(body: Node2D):
	if body.has_method("player"):
		print("enter cliff and has player")
		Global.transition_scene = true
		print(Global.transition_scene)

func _on_cliffside_transition_point_body_exited(body: Node2D):
	if body.has_method("player"):
		print("exit cliff and has player")
		#Global.transition_scene = false

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			Global.finish_changescenes()
