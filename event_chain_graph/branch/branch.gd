extends Polygon2D
var info_label

var begin_pos
var end_pos
var rect_color
var info

func _ready():
	pass

func _draw():
	pass

func _process(delta):
	update()

func clear_label():
	if info_label:
		info_label.queue_free()

func draw(begin_pos,end_pos,rect_color,info):
	self.begin_pos = begin_pos
	self.end_pos = end_pos
	self.rect_color = rect_color
	self.info = info
	clear_label()
	polygon.resize(0)
	polygon = PoolVector2Array([
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,begin_pos.y),
	Vector2(end_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y),
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,end_pos.y),
	Vector2(begin_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y)
	])
	color = rect_color

	if info:
		info_label = Label.new()
		info_label.text = str(info)
		info_label.align = HALIGN_CENTER
		info_label.valign = VALIGN_CENTER
		add_child(info_label)
		info_label.modulate= Color.darkgray
		info_label.rect_position = (begin_pos+end_pos)/2-info_label.rect_size/2

func change_end_pos(end_pos):
	self.draw(begin_pos,end_pos,rect_color,info)
