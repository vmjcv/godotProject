# 事件类，封装触发信号，状态改变前信号，状态改变后信号，触发回调数组
tool
class_name EventChainGraphEvent
extends Object

var signal_trigger_obj # 触发信号对象
var signal_before_obj # 状态改变前信号对象
var signal_after_obj # 状态改变后信号对象
var callback_list # 回调队列
