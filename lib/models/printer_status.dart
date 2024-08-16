class PrinterStatus {
  int? id;
  String? name;
  String? ip;
  DateTime? date;
  int? monoCount;
  int? monoTotal;
  int? colorCount;
  int? colorTotal;

  PrinterStatus({
    required this.id,
    required this.name,
    required this.ip,
    required this.date,
    this.monoCount,
    this.monoTotal,
    this.colorCount,
    this.colorTotal,
  });

  // fromJson yöntemi
  factory PrinterStatus.fromJson(Map<String, dynamic> json) {
    return PrinterStatus(
      id: json['id'] as int?,
      name: json['name'] as String?,
      ip: json['ip'] as String?,
      date: DateTime.parse(json['date'] as String),
      monoCount: json['monoCount'] as int?,
      monoTotal: json['monoTotal'] as int?,
      colorCount: json['colorCount'] as int?,
      colorTotal: json['colorTotal'] as int?,
    );
  }

  // toJson yöntemi
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ip': ip,
      'date': date?.toIso8601String(),
      'monoCount': monoCount,
      'monoTotal': monoTotal,
      'colorCount': colorCount,
      'colorTotal': colorTotal,
    };
  }
}
