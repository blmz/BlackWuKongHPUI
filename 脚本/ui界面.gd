extends Control

@onready var 血条: 状态条类 = $"状态UI/血条"
@onready var 蓝条: 状态条类 = $"状态UI/蓝条"
@onready var 体力条: 状态条类 = $"状态UI/体力条"
@onready var 血量操作滑块: HSlider = $"血量操作滑块"
@onready var 蓝量操作滑块: HSlider = $"蓝量操作滑块"
@onready var 体力条操作滑块: HSlider = $"体力条操作滑块"

func _on_扣血按钮_button_up() -> void:
	血条.减值(血量操作滑块.value)

func _on_血量操作滑块_value_changed(value: float) -> void:
	$"血量操作滑块/数值显示".text=str(value)

func _on_加血按钮_button_up() -> void:
	血条.加值(血量操作滑块.value)

func _on_扣按钮_button_up() -> void:
	蓝条.减值(蓝量操作滑块.value)

func _on_加按钮_button_up() -> void:
	蓝条.加值(蓝量操作滑块.value)

func _on_蓝量操作滑块_value_changed(value: float) -> void:
	$"蓝量操作滑块/数值显示".text=str(value)

func _on_体力条操作滑块_value_changed(value: float) -> void:
	$"体力条操作滑块/数值显示".text=str(value)

func _on_体力扣按钮_button_up() -> void:
	体力条.减值(体力条操作滑块.value)

func _on_体力加按钮_button_up() -> void:
	体力条.加值(体力条操作滑块.value)
