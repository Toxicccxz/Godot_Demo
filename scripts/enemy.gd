extends CharacterBody2D

var SPEED = 40
var player_chase = false
var player = null

var health = 100
var player_inattact_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position) / SPEED
		
		$AnimatedSprite2D.play("walk")
		
		if (player.position.x - position.x ) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	
func enemy():
		pass


func _on_enemy_hitbox_body_entered(body: Node2D):
	if body.has_method("player"):
		player_inattact_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D):
	if body.has_method("player"):
		player_inattact_zone = false

func deal_with_damage():
	if player_inattact_zone and Global.player_current_attact == true:
		if can_take_damage == true:
			health = health - 20
			$take_danage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()


func _on_take_danage_cooldown_timeout():
	can_take_damage = true
