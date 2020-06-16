extends Node

var area0:Dictionary setget set_area0
var area1:Dictionary setget set_area1
var area2:Dictionary setget set_area2
var area3:Dictionary

func _ready():
	area0["status"]=true
	area0["control"]=100.0
	area1["status"]=false
	area1["control"]=0.0
	area2["status"]=false
	area2["control"]=0.0
	area3["status"]=false
	area3["control"]=0.0

func set_area0(value):
	area0["control"]=value["control"]

func set_area1(value):
	area1["control"]=value["control"]

func set_area2(value):
	area2["control"]=value["control"]
