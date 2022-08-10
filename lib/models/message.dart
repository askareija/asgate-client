class Message {
  String? to;
  String? content;
  String? deviceId;

  Message({this.to, this.content, this.deviceId});

  Message.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    content = json['content'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['to'] = to;
    data['content'] = content;
    data['device_id'] = deviceId;
    return data;
  }
}
