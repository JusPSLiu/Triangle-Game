extends Sprite2D

@export var onSprite : Texture2D
@export var offSprite: Texture2D
@export var onsound: AudioStreamPlayer
@export var eeeeeee: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.updateTv.connect(_reset_tv)
	_reset_tv()

func _toggle():
	GlobalVariables.tvOn = !GlobalVariables.tvOn
	if (onsound is AudioStreamPlayer):
		onsound.pitch_scale = 1 if GlobalVariables.tvOn else 0.84 
		onsound.play()
	SignalBus.updateTv.emit()

func _reset_tv():
	if (GlobalVariables.tvOn):
		set_texture(onSprite)
		if (eeeeeee is AudioStreamPlayer):
			eeeeeee.volume_db = -20
	else:
		set_texture(offSprite)
		if (eeeeeee is AudioStreamPlayer):
			eeeeeee.volume_db = -80
