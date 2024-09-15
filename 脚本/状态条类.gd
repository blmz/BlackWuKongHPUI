class_name 状态条类
extends Node

@export var 背景框: ColorRect 
@export var 减值条: ColorRect 
@export var 加值条: ColorRect 
@export var 前景条: ColorRect 

@export_group("玩家参数")
@export var 玩家值上限:float=100
@export var 玩家当前值:float=0

@export_group("减值动画")
@export var 是否减动画:bool=true
@export var 是否减值变色:bool =true
@export var 减值动画颜色1:Color
@export var 减值动画颜色2:Color
@export var 减值动画速度:float=1
@export var 减值停留时间:float=1
@export var 减值变色停留时间:float=1
@export var 减值变色速度:float=0.3
@export_group("加值动画")
@export var 是否加动画:bool=true
@export var 是否加值变色:bool =true
@export var 加值动画颜色1:Color
@export var 加值动画颜色2:Color
@export var 加值动画速度:float=0.5
@export var 加值停留时间:float=1
@export var 加值变色停留时间:float=1
@export var 加值变色速度:float=0.3
@export_group("闪烁动画")
@export var 是否闪烁动画:bool=true
@export var 低值闪烁阈值:float=0.2
@export var 低值闪烁速度:float=1
@export var 闪烁颜色1:Color
@export_group("其他")
@export var 动画插值函数:Tween.TransitionType
@export var 前景条颜色:Color


var 背景框UI长度:float
var 插值列表:Array[Tween]

func 减值(值:float):
	停止所有插值()
	减值条.visible=true
	加值条.visible=false
	玩家当前值-=值
	if(玩家当前值<0):
		玩家当前值=0
	前景条.size.x=(玩家当前值/玩家值上限)*背景框UI长度
	加值条.size=前景条.size
	if 是否减动画:
		减值条.color=减值动画颜色1
		if 是否减值变色:
			插值(减值条,"color",减值动画颜色2,减值变色速度,减值变色停留时间)
		插值(减值条,"size",前景条.size,减值动画速度,减值停留时间+减值变色停留时间)
	else:
		减值条.size=前景条.size

func 加值(值:float):
	停止所有插值()
	减值条.visible=false
	加值条.visible=true
	var 目标值
	#直接插值
	玩家当前值+=值
	if(玩家当前值>玩家值上限):
		玩家当前值=玩家值上限
	目标值=Vector2((玩家当前值/玩家值上限)*背景框UI长度,背景框.size.y) 
	减值条.size=目标值
	if 是否加动画:
		插值(加值条,"size",目标值,加值动画速度,0)
		加值条.color=加值动画颜色1
		if 是否加值变色:
			插值(加值条,"color",加值动画颜色2,加值变色速度,减值变色停留时间)
		插值(前景条,"size",目标值,加值动画速度,加值停留时间)
	else:
		前景条.size=目标值
		加值条.size=目标值

func 低值闪烁():
	if((玩家当前值/玩家值上限)*100<=20 and 是否闪烁动画):
		#先变白再变红
		插值(前景条,"color",前景条颜色,低值闪烁速度,0)
		插值(前景条,"color",闪烁颜色1,低值闪烁速度,低值闪烁速度)

func 插值(对象:Node,属性:NodePath,目标值,时间:float,延时:float=0,是否无限循环:bool=false):
	var 插值= create_tween()#创建插值
	插值列表.append(插值)
	插值.set_process_mode(Tween.TWEEN_PROCESS_IDLE)#每个处理帧插值
	插值.set_ease(Tween.EASE_OUT)
	插值.set_trans(动画插值函数)
	if 是否无限循环:
		插值.set_loops()
	插值.tween_interval(延时)
	插值.tween_property(对象,属性,目标值,时间)

func 停止所有插值():
	for 插值 in 插值列表:
		插值.stop()

func 初始化():
	玩家当前值=玩家值上限
	背景框UI长度=背景框.size.x
	减值条.size.x=背景框UI长度
	加值条.size.x=背景框UI长度
	前景条.size.x=背景框UI长度
	前景条.color=前景条颜色

func _ready() -> void:
	初始化()
	

func _process(delta: float) -> void:
	pass
	
	
