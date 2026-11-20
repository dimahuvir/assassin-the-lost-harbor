
extends Node2D

const PLAYER_SCENE = preload("res://scenes/player.tscn")

var player: CharacterBody2D

func _ready():
    player = PLAYER_SCENE.instantiate()
    add_child(player)
    player.position = Vector2(0, 150)

func _draw():
    # Основная земля
    draw_rect(
        Rect2(-1200, -900, 2400, 1800),
        Color("#65594d")
    )

    # Каменная мостовая
    for x in range(-1200, 1200, 32):
        for y in range(-900, 900, 32):
            draw_rect(
                Rect2(x, y, 30, 30),
                Color("#74675a"),
                false,
                1
            )

    # Главная улица
    draw_rect(
        Rect2(-1200, -170, 2400, 340),
        Color("#89745d")
    )

    # Дорога к порту
    draw_rect(
        Rect2(-170, -900, 340, 1800),
        Color("#89745d")
    )

    # Здания слева
    _draw_building(
        Vector2(-650, -390),
        Vector2(220, 190),
        Color("#a77c59"),
        Color("#493c43")
    )

    _draw_building(
        Vector2(-650, 80),
        Vector2(220, 180),
        Color("#b18b65"),
        Color("#55413e")
    )

    # Здания справа
    _draw_building(
        Vector2(430, -390),
        Vector2(220, 190),
        Color("#a77c59"),
        Color("#493c43")
    )

    _draw_building(
        Vector2(430, 80),
        Vector2(220, 180),
        Color("#a88a6c"),
        Color("#55413e")
    )

    # Фонтан на площади
    draw_circle(
        Vector2(0, 0),
        52,
        Color("#49433e")
    )

    draw_circle(
        Vector2(0, 0),
        43,
        Color("#72a7ad")
    )

    draw_circle(
        Vector2(0, 0),
        12,
        Color("#d0c4a3")
    )

    # Торговые палатки
    _draw_stall(Vector2(-290, -60), Color("#a74c35"))
    _draw_stall(Vector2(290, -60), Color("#547d62"))
    _draw_stall(Vector2(-290, 220), Color("#bd8950"))
    _draw_stall(Vector2(290, 220), Color("#9b5140"))

    # Портовая вода
    draw_rect(
        Rect2(-1200, 560, 2400, 340),
        Color("#345b69")
    )

    # Причалы
    draw_rect(
        Rect2(-420, 460, 150, 220),
        Color("#79533c")
    )

    draw_rect(
        Rect2(270, 460, 150, 220),
        Color("#79533c")
    )

    # Декоративные корабли
    _draw_ship(Vector2(-340, 690))
    _draw_ship(Vector2(340, 690))

    # Названия районов
    draw_string(
        ThemeDB.fallback_font,
        Vector2(-95, -90),
        "OLD HARBOR",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        20,
        Color("#f4dfb4")
    )

func _draw_building(pos, size, wall_color, roof_color):
    # Тень
    draw_rect(
        Rect2(pos + Vector2(10, 12), size),
        Color("#302b2c")
    )

    # Стены
    draw_rect(
        Rect2(pos, size),
        wall_color
    )

    # Крыша
    draw_rect(
        Rect2(pos - Vector2(8, 15), Vector2(size.x + 16, 38)),
        roof_color
    )

    # Дверь
    draw_rect(
        Rect2(pos + Vector2(size.x / 2 - 14, size.y - 48),
        Vector2(28, 48)),
        Color("#49332d")
    )

    # Окна
    draw_rect(
        Rect2(pos + Vector2(20, 65), Vector2(28, 32)),
        Color("#f3c477")
    )

    draw_rect(
        Rect2(pos + Vector2(size.x - 48, 65), Vector2(28, 32)),
        Color("#f3c477")
    )

func _draw_stall(pos, roof_color):
    draw_rect(
        Rect2(pos, Vector2(110, 65)),
        Color("#76503b")
    )

    draw_rect(
        Rect2(pos - Vector2(5, 10), Vector2(120, 25)),
        roof_color
    )

    draw_rect(
        Rect2(pos + Vector2(10, 35), Vector2(90, 12)),
        Color("#b58a59")
    )

func _draw_ship(pos):
    # Корпус
    draw_colored_polygon(
        PackedVector2Array([
            pos + Vector2(0, 0),
            pos + Vector2(120, 0),
            pos + Vector2(95, 45),
            pos + Vector2(25, 45)
        ]),
        Color("#49342c")
    )

    # Мачта
    draw_rect(
        Rect2(pos + Vector2(55, -100), Vector2(5, 100)),
        Color("#563c2b")
    )

    # Парус
    draw_colored_polygon(
        PackedVector2Array([
            pos + Vector2(60, -95),
            pos + Vector2(60, -15),
            pos + Vector2(110, -15)
        ]),
        Color("#e2d3a9")
    )
