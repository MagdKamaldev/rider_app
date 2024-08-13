class ZoneReponse {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<dynamic>? shopBranches;
  List<dynamic>? riders;

  ZoneReponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.shopBranches,
    this.riders,
  });

  factory ZoneReponse.fromJson(Map<String, dynamic> json) => ZoneReponse(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        shopBranches: json['shop_branches'] as List<dynamic>?,
        riders: json['riders'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'shop_branches': shopBranches,
        'riders': riders,
      };
}
