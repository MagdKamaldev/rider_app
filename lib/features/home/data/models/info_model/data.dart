class Data {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  int? userId;
  String? nationalId;
  String? mobileNumber;
  int? zoneId;
  int? lat;
  int? lng;
  String? locationUpdatedAt;
  bool? isAvailable;
  bool? isInShift;

  Data({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.userId,
    this.nationalId,
    this.mobileNumber,
    this.zoneId,
    this.lat,
    this.lng,
    this.locationUpdatedAt,
    this.isAvailable,
    this.isInShift,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        userId: json['user_id'] as int?,
        nationalId: json['national_id'] as String?,
        mobileNumber: json['mobile_number'] as String?,
        zoneId: json['zone_id'] as int?,
        lat: json['lat'] as int?,
        lng: json['lng'] as int?,
        locationUpdatedAt: json['location_updated_at'] as String?,
        isAvailable: json['is_available'] as bool?,
        isInShift: json['is_in_shift'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'user_id': userId,
        'national_id': nationalId,
        'mobile_number': mobileNumber,
        'zone_id': zoneId,
        'lat': lat,
        'lng': lng,
        'location_updated_at': locationUpdatedAt,
        'is_available': isAvailable,
        'is_in_shift': isInShift,
      };
}
