extends Camera2D

@export var zoomSpeed: float = 10;
var zoomTarget: Vector2
var dragStart_mousePos = Vector2.ZERO
var dragStart_cameraPos = Vector2.ZERO
var isDragging: bool = false

func _ready() -> void:
	zoomTarget = zoom

func _process(delta):
	Zoom(delta)
	SimplePan(delta)
	ClickAndDrag()

func Zoom(delta):
	if Input.is_action_just_pressed("Camera_zoomIn") and zoom < Vector2(7.400249, 7.400249):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("Camera_zoomOut") and zoom > Vector2(0.197845, 0.197845):
		zoomTarget /= 1.1
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func SimplePan(delta):
	var moveAmount = Vector2.ZERO
	if Input.is_action_pressed("Camera_moveRight"):
		moveAmount.x += 1
	if Input.is_action_pressed("Camera_moverLeft"):
		moveAmount.x -= 1
	if Input.is_action_pressed("Camera_moveDown"):
		moveAmount.y += 1
	if Input.is_action_pressed("Camera_moveUp"):
		moveAmount.y -= 1
	if Input.is_action_pressed("Camera_moveHome"):
		position = Vector2(0,0)
		zoom = Vector2(1,1)
		zoomTarget = zoom
		
	moveAmount = moveAmount.normalized()
	position += moveAmount * delta * 1000 * (1/zoom.x)
	
func ClickAndDrag():
	if !isDragging and Input.is_action_just_pressed("Camera_pain"):
		dragStart_mousePos = get_viewport().get_mouse_position()
		dragStart_cameraPos = position
		isDragging = true
	
	if isDragging and Input.is_action_just_released("Camera_pain"):
		isDragging = false
	
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStart_mousePos
		position = dragStart_cameraPos - moveVector * (1/zoom.x)
