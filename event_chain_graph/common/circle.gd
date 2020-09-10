extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	draw(50)
	pass # Replace with function body.


func draw(radius):
	rect_size=Vector2(2*radius,2*radius)
	$shape.shape.radius = radius
	$shape.position = Vector2(radius,radius)
	rect_position = Vector2(-radius,-radius)
