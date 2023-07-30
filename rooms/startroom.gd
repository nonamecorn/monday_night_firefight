extends Node2D

signal started

func spawn_corr():
	$connector.call_deferred("spawn_exact","res://rooms/basiccorridor.tscn")
