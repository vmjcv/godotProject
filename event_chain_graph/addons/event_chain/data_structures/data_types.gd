tool
class_name EventChainGraphDataType

# 编辑器节点数据类型

enum Types {
	ANY,
	BOOLEAN,
	SCALAR,
	STRING,
	LIST,

	EVENT,
	SIGNAL,
	CALLBACK,
	STATUS,
}

const ANY = Types.ANY
const BOOLEAN = Types.BOOLEAN
const SCALAR = Types.SCALAR
const STRING = Types.STRING
const LIST = Types.LIST

const EVENT = Types.EVENT
const SIGNAL = Types.SIGNAL
const CALLBACK = Types.CALLBACK
const STATUS = Types.STATUS

# 插槽颜色
const COLORS = {
	ANY: Color.white,
	BOOLEAN: Color("8ca6f4"),
	SCALAR: Color("61d9f5"),
	STRING: Color.gold,
	LIST: Color.brown,
	
	EVENT: Color.crimson,
	SIGNAL: Color("7e3f97"),
	CALLBACK: Color("8e654f"),
	STATUS: Color("d67ded"),
}

static func to_category_color(category: String) -> Color:
	# @:节点类型生成的颜色
	var tokens := category.split("/")
	tokens.invert()
	var type = tokens[0]

	match type:
		"Status":
			return Color.darkmagenta
		"Callback":
			return Color.aqua
		"Event":
			return Color("b48700")
		"Signal":
			return Color("cc8f20")
		"Debug":
			return Color.black
		"Inputs":
			return Color.steelblue
		"Inspector":
			return Color.teal
		"Maths":
			return Color.steelblue
		"Nodes":
			return Color.firebrick
		"Output":
			return Color.black
		"Utilities":
			return Color("4371b5")
		"Scalars":
			return COLORS[SCALAR].darkened(0.3)
		_:
			return Color.black
			
			
static func setup_valid_connection_types(graph_edit: GraphEdit) -> void:
	# @:允许不同的类型相互链接
	for type in Types.values():
		graph_edit.add_valid_connection_type(ANY, type)

static func to_variant_type(type: int) -> int:
	# @:得到数据的类型，用于导入编辑器时使用
	match type:
		SCALAR:
			return TYPE_REAL
		STRING:
			return TYPE_STRING
		BOOLEAN:
			return TYPE_BOOL
		LIST:
			return TYPE_ARRAY
	return TYPE_NIL


static func to_logic_type(type):
	match type:
		"status":
			return EventChainGraphStatus
		"callback":
			return EventChainGraphCallback
		"event":
			return EventChainGraphEvent
		"signal":
			return EventChainGraphSignal
		_:
			return null
