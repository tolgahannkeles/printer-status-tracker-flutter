class Printer {
  int? id;
  String? ip;
  String? model;
  String? name;
  String? serialNo;
  bool? isAvailable;

  Printer({
    required this.id,
    required this.ip,
    this.name,
    this.model,
    this.serialNo,
    this.isAvailable,
  });

  // Converts a JSON map into a Printer object
  factory Printer.fromJson(Map<String, dynamic> json) {
    return Printer(
      id: json['id'] as int?,
      ip: json['ip'] as String?,
      name: json['name'] as String?,
      model: json['model'] as String?,
      serialNo: json['serialNo'] as String?,
      isAvailable: json['isAvailable'] as bool?,
    );
  }

  // Converts a Printer object into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ip'] = ip;
    data['name'] = name;
    data['model'] = model;
    data['serialNo'] = serialNo;
    data['isAvailable'] = isAvailable;
    return data;
  }

  @override
  String toString() {
    return 'Printer: {id: $id, ip: $ip, model: $model, name: $name, serialNo: $serialNo}';
  }
}
