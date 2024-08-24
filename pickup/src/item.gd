class_name Item
extends Resource


enum ItemPropertyKind{
	NONE = 0,
	EXTEND_TIME = 1,
}


@export var PropertyKind: ItemPropertyKind
@export var Property: int
@export var Scene: PackedScene
