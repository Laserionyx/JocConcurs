extends CharacterBody2D

var v = Global.viteza
var s = -450.0
var g = 1500.0
var viata = Global.viata_maxima_jucator

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += g * delta

	if (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_SPACE)) and is_on_floor():
		velocity.y = s
	if (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_SPACE)) and is_on_floor():
		$Jump.play()
		
		

	var d = 0.0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		d -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		d += 1.0
		
	velocity.x = d * v
	move_and_slide()

func primeste_damage():
	viata -= 1
	await get_tree().create_timer(0.15).timeout
	if viata <= 0:
		get_tree().reload_current_scene()
