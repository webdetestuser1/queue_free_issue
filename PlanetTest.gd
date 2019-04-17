extends Node2D

const BLACK_HOLE_START_HP = 10
var black_hole_hp = BLACK_HOLE_START_HP

onready var p1 = $Pivot1
#onready var p2 = $Pivot2
#onready var p1_planet = $Pivot1/Planet
#onready var p2_planet = $Pivot2/Planet

const MAX_CREEPS = 20
var creeps = 0

const CREEP_SCENE = preload("res://Creep.tscn")

func _ready():
	$BlackHole.connect("area_entered", self, "_on_black_hole_entered")
	spawn_creep()
	$CreepTimer.connect("timeout", self, "spawn_creep")
	autoload.black_hole_position = $BlackHole.position

func _process(delta):
	# planet orbit
	p1.rotate(deg2rad(0.25))
#	p2.rotate(deg2rad(0.4))
	
#	p1_planet.target = null
	
	$HP.text = "BLACK HOLE HP: " + str(black_hole_hp)

func _on_black_hole_entered(area):
	black_hole_hp -= 1
	area.queue_free()

func spawn_creep():
	creeps += 1
	if creeps == MAX_CREEPS:
		$CreepTimer.disconnect("timeout", self, "spawn_creep")
	
	var creep = CREEP_SCENE.instance()
	creep.position = $CreepSpawn.position
#	creep.connect("black_hole_entered", self, "_on_black_hole_entered")
	add_child(creep)
	$CreepTimer.start()
	