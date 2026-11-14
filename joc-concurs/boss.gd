extends StaticBody2D

var viata = 2
var directie = 1

func _physics_process(delta):
	position.y += directie * 120.0 * delta
	if position.y > 450:
		directie = -1
	elif position.y < 150:
		directie = 1

func lovit():
	$Auuu.play()
	viata -= Global.damage_minge
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	
	if viata <= 0:
		queue_free()
		
