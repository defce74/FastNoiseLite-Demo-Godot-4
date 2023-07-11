# Camera.gd
#---------------------------------
extends Camera2D

#---------------------------------
var m_dragSensitivity: float = 20.0
enum m_cameraMovement { left, right, up, down }

var m_zoomSpeed: Vector2 = Vector2(0.05, 0.05)
var m_zoomMin: Vector2 = Vector2(0.4, 0.4)
var m_zoomMax: Vector2 = Vector2(1.5, 1.5)

#---------------------------------
func setPosition(value: int):
	match value:
		m_cameraMovement.left: position.x -= m_dragSensitivity / zoom.x
		m_cameraMovement.right: position.x += m_dragSensitivity / zoom.x
		m_cameraMovement.up: position.y -= m_dragSensitivity / zoom.y
		m_cameraMovement.down: position.y += m_dragSensitivity / zoom.y

#---------------------------------
func setZoom(value):
	# set_zoom(value)
	set_zoom(value.clamp(m_zoomMin, m_zoomMax))

#---------------------------------
func _process(_delta):
	pass # moveCamera()

#---------------------------------
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP: # camera zoom in
			setZoom(zoom + m_zoomSpeed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN: # camera zoom out
			setZoom(zoom - m_zoomSpeed)
		elif event.button_index == MOUSE_BUTTON_LEFT:
			print('get_viewport_rect(): ', get_viewport_rect())
	
#---------------------------------
func moveCamera():
	if get_viewport().get_mouse_position().x < 0:
		setPosition(m_cameraMovement.left)
	if get_viewport().get_mouse_position().x > get_viewport_rect().end.x:
		setPosition(m_cameraMovement.right)
	if get_viewport().get_mouse_position().y < 0:
		setPosition(m_cameraMovement.up)
	if get_viewport().get_mouse_position().y > get_viewport_rect().end.y:
		setPosition(m_cameraMovement.down)

#---------------------------------


