extends Camera2D

const MIN_ZOOM = Vector2(0.2, 0.2)
const MAX_ZOOM = Vector2(1, 1)
const ZOOM_SPEED = 0.2

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if zoom > MIN_ZOOM:
					zoom = lerp(zoom, MIN_ZOOM, ZOOM_SPEED)
			if event.button_index == BUTTON_WHEEL_DOWN:
				if zoom < MAX_ZOOM:
					zoom = lerp(zoom, MAX_ZOOM, ZOOM_SPEED)
