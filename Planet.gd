extends Node2D

var target = null
var can_shoot = true

var aim_position = Vector2()

const planet_bullet_scene = preload("res://PlanetBullet.tscn")

func _ready():
	$Timer.connect("timeout", self, "_on_timeout")

func _process(delta):
#	look_at(target.global_position)
	_shoot()

func _shoot():
	if not can_shoot:
		return
	
	var creeps = get_tree().get_nodes_in_group("Creeps")
	
	if creeps.size() == 0:
		return
	
	print("-------------------------")
	print(creeps)
	print("target ", target)
	
	# WORKING VESRION
#	target = null
#	target = creeps[0]

	# VERSION A:
	if target == null:
		target = creeps[0]
	else:
		var wr = weakref(target)
		if not wr.get_ref():
			print("object is erased")
			target = creeps[0]
	
#	if not is_instance_valid(target) or target == null:
#		print("\tNOT VALID!!!")
#		target = creeps[0]
#	else:
#		print("VALID!")
	
#	if target == null or target.is_queued_for_deletion():
#		print("####### IF")
#		target = creeps[0]
#	else:
#		print("####### ELSE")
	
	# shoot
	if target.velocity == Vector2():
		return
	
	var bullet = planet_bullet_scene.instance()
	bullet.position = $BulletSpawn.global_position
#	bullet.velocity = target.global_position - bullet.position
	
	var time = bullet.position.distance_to(target.global_position) / bullet.SPEED
	aim_position = target.global_position + (time * target.velocity.normalized() * target.SPEED)
	
	bullet.velocity = aim_position - bullet.position
	get_tree().root.add_child(bullet)
	look_at(aim_position)
	
	# start timer
	$Timer.start()
	can_shoot = false

func _on_timeout():
	can_shoot = true