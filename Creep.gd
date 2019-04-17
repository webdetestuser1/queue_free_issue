extends Area2D

const MAX_HP = 4
var hp = MAX_HP

var target_pos = Vector2()
var velocity = Vector2()
const SPEED = 75

#signal black_hole_entered

func _ready():
#	connect("area_entered", self, "_on_area_entered")
	add_to_group("Creeps")
	

func _process(delta):
#	velocity = target_pos - position
	velocity = autoload.black_hole_position - position
	position += velocity.normalized() * SPEED * delta
#	var distance = position.distance_to(target_pos)
	
#	print(distance)
#	if distance < 2.0:
#		queue_free()
#	else:
#		$HP.text = str(hp)
	$HP.text = str(hp)

#func _on_area_entered(area):
#	if area.name == "BlackHole":
#		emit_signal("black_hole_entered")
#		print("\tDELITING ", self)
#		queue_free()
#	else:
#		area.queue_free()
#		hp -= 1
#		if hp <= 0:
#			print("\tDELITING ", self)
#			queue_free()
