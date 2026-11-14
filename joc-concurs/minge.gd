extends RigidBody2D

@onready var jucator = get_parent().get_node("Jucator")

var gata = true
var putere = 580.0
var bouncuri = 0
var timp_zbor = 0.0

func _physics_process(delta):
	queue_redraw()
	if gata:
		freeze = true
		global_position = jucator.global_position + Vector2(0, -97)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$SunetAruncare.play()
			gata = false
			freeze = false
			timp_zbor = 0.0
			bouncuri = 0
			var dir = (get_global_mouse_position() - global_position).normalized()
			linear_velocity = dir * Global.putere_minge
	else:
		timp_zbor += delta
		for corp in get_colliding_bodies():
			if corp == jucator and timp_zbor > 0.25:
				gata = true
				$PickUp.play()
			elif corp != jucator:
				$SunetRicoseu.play()
				if corp.has_method("lovit"):
					corp.lovit()
				bouncuri += 1
				if bouncuri >= Global.max_bouncuri:
					penalizare()
					break

func penalizare():
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(5.0).timeout
	visible = true
	$CollisionShape2D.set_deferred("disabled", false)
	gata = true

func _draw():
	if gata:
		var dir = (get_global_mouse_position() - global_position).normalized()
		draw_line(Vector2.ZERO, dir * 80, Color.WHITE, 3.0)
var atac=1
