extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true

var attact_ip = false

const SPEED = 100.0
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	
	if health <= 0:
		player_alive = false
		health = 0
		print('player has been killed')
		self.queue_free()

func player_movement(delta: float) -> void:

	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		player_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		player_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		player_animation(1)			
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		player_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		player_animation(0)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func player_animation(movement):
	var dir = current_dir
	var animation = $AnimatedSprite2D

	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			if attact_ip == false:
				animation.play("side_idle")
	if dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			if attact_ip == false:
				animation.play("side_idle")
	if dir == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			if attact_ip == false:
				animation.play("front_idle")
	if dir == "up":
		animation.flip_h = false
		if movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			if attact_ip == false:
				animation.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attact = true
		attact_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attact_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attact_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attact_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attact_timer.start()


func _on_deal_attact_timer_timeout():
	$deal_attact_timer.stop()
	Global.player_current_attact = false
	attact_ip = false
	
func current_camera():
	if Global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
	elif Global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
