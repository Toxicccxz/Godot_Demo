extends Node2D

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	change_scenes()


func _on_cliffside_exit_point_body_entered(body: Node2D):
	if body.has_method("player"):
		print("enter")
		Global.transition_scene = true

func _on_cliffside_exit_point_body_exited(body: Node2D):
	if body.has_method("player"):
		print("exit")
		Global.transition_scene = false
		
func change_scenes():
	if Global.transition_scene == true:
		#print(Global.current_scene)
		if Global.current_scene == "cliff_side":
			print("456")
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
