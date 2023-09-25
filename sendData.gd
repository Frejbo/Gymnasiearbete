extends HTTPRequest


var my_full_url = "https://docs.google.com/forms/d/e/1FAIpQLSea1QXNt3LSCT-HTK8A6qwb1yEB__LGdFTuDcD8N9srE_HBiw/formResponse"
var my_data = {
	"entry.172221692" : OS.get_unique_id(),
	"entry.953122580" : 0.0}
var headers = ["Content-Type: application/x-www-form-urlencoded"]
var http = HTTPClient.new()

func _on_complete_complete():
	my_data["entry.953122580"] = get_parent().time
	send_data()

func send_data():
	# Transform data so it can be sent:
	var headers_pool = PackedStringArray(headers)
	var my_data_ready = http.query_string_from_dict(my_data)
	#Send data
	self.request(my_full_url, headers_pool, http.METHOD_POST, my_data_ready)



func _on_request_completed(result, response_code, headers, body):
	if response_code == http.RESPONSE_OK:
		get_tree().change_scene_to_file("res://slutskärm.tscn")
	else:
		pass
