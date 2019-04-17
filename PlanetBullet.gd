extends Area2D

var velocity = Vector2()
const SPEED = 500

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _physics_process(delta):
	position += velocity.normalized() * SPEED * delta

func _on_area_entered(area):
	area.hp -= 1
	if area.hp <= 0 and not area.is_queued_for_deletion():
		area.queue_free()
	queue_free()