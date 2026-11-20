
extends CharacterBody2D

@export var speed: float = 150.0

var touch_direction := Vector2.ZERO
var active_touch := -1
var joystick_origin := Vector2.ZERO
var facing := Vector2.DOWN

func _ready():
    _register_action("move_up", KEY_W, KEY_UP)
    _register_action("move_down", KEY_S, KEY_DOWN)
    _register_action("move_left", KEY_A, KEY_LEFT)
    _register_action("move_right", KEY_D, KEY_RIGHT)

func _register_action(action_name: String, key_a: Key, key_b: Key):
    if not InputMap.has_action(action_name):
        InputMap.add_action(action_name)

    var event_a = InputEventKey.new()
    event_a.physical_keycode = key_a
    InputMap.action_add_event(action_name, event_a)

    var event_b = InputEventKey.new()
    event_b.physical_keycode = key_b
    InputMap.action_add_event(action_name, event_b)

func _physics_process(_delta):
    var keyboard_direction = Input.get_vector(
        "move_left",
        "move_right",
        "move_up",
        "move_down"
    )

    var direction = keyboard_direction

    if direction == Vector2.ZERO:
        direction = touch_direction

    if direction.length() > 0.1:
        facing = direction.normalized()

    velocity = direction.normalized() * speed
    move_and_slide()

func _input(event):
    if event is InputEventScreenTouch:

        if event.pressed:
            if event.position.x < get_viewport_rect().size.x * 0.55:
                active_touch = event.index
                joystick_origin = event.position
                touch_direction = Vector2.ZERO

        elif event.index == active_touch:
            active_touch = -1
            touch_direction = Vector2.ZERO

    elif event is InputEventScreenDrag:
        if event.index == active_touch:
            var offset = event.position - joystick_origin

            if offset.length() > 12:
                touch_direction = offset.normalized()

func _draw():
    # Тень
    draw_rect(
        Rect2(-8, 3, 16, 5),
        Color("#302b2a")
    )

    # Ноги
    draw_rect(
        Rect2(-6, 5, 5, 7),
        Color("#49352d")
    )

    draw_rect(
        Rect2(1, 5, 5, 7),
        Color("#49352d")
    )

    # Плащ
    draw_rect(
        Rect2(-7, -5, 14, 13),
        Color("#762e35")
    )

    # Тело
    draw_rect(
        Rect2(-5, -9, 10, 13),
        Color("#55423b")
    )

    # Голова
    draw_rect(
        Rect2(-5, -16, 10, 9),
        Color("#c18b69")
    )

    # Капюшон
    draw_rect(
        Rect2(-7, -18, 14, 5),
        Color("#492c32")
    )

    # Верх капюшона
    draw_rect(
        Rect2(-4, -21, 8, 4),
        Color("#492c32")
    )
