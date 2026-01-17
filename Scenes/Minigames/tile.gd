extends TextureButton

var number 

signal tile_pressed
signal slide_completed

# Updates the number label on tiles
func set_text(new_number):
	number = new_number
	$Number/Label.text = str(number)
	
# Updates the background image of tiles
func set_sprite(new_frame, size, tile_size):
	var sprite = $Sprite2D
	
	update_size(size, tile_size)
	sprite.set_hframes(size)
	sprite.set_vframes(size)
	sprite.set_frame(new_frame)
	
# Scales everthing to new tile size
func update_size(size, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	$Number.set_size(new_size)
	$Number/ColorRect.set_size(new_size)
	$Number/Label.set_size(new_size)
	$Panel.set_size(new_size)
	
	var to_scale = size * (new_size / $Sprite2D.texture.get_size())
	$Sprite2D.set_scale(to_scale)
	
# Update full puzzle image
func set_sprite_texture(texture):
	$Sprite2D.set_texture(texture)

# Slide tile to a new position w/ tween
func slide_to(new_position, duration):
	var tween = create_tween()
	tween.interpolate_property(self, "rect_position", null, new_position, duration,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.finished.connect("slide_completed")
	tween.start()

# Set number visibility to true / false
func set_number_visible(state):
	$Number.visible = state
	
# Tile is pressed, send signal
func _on_Tile_pressed():
	emit_signal("tile_pressed", number)
	
