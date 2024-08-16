class MonthlyTotal {
  int? monoCount;
  int? colorCount;
  MonthlyTotal({this.monoCount, this.colorCount});

  factory MonthlyTotal.fromJson(Map<String, dynamic> json) {
    return MonthlyTotal(
      monoCount: json['totalMonoCount'] as int?,
      colorCount: json['totalColorCount'] as int?,
    );
  }
}
