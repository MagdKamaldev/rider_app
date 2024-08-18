class LatestShift {
  int? id;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? riderId;
  String? startTime;
  String? endTime;

  LatestShift({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.riderId,
    this.startTime,
    this.endTime,
  });

  factory LatestShift.fromJson(Map<String, dynamic> json) => LatestShift(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] as String?,
        updatedAt: json['UpdatedAt'] as String?,
        deletedAt: json['DeletedAt'] as dynamic,
        riderId: json['rider_id'] as int?,
        startTime: json['start_time'] as String?,
        endTime: json['end_time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt,
        'UpdatedAt': updatedAt,
        'DeletedAt': deletedAt,
        'rider_id': riderId,
        'start_time': startTime,
        'end_time': endTime,
      };
}
