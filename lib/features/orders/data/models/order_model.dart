class OrderModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? shopBranchId;
  int? zoneId;
  int? riderId;
  String? deliveryAddress;
  bool? isDelivered;
  String? clientName;
  String? branchName;
  OrderModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.shopBranchId,
      this.zoneId,
      this.riderId,
      this.deliveryAddress,
      this.isDelivered,
      this.clientName,
      this.branchName});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json['ID'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'] as dynamic,
      shopBranchId: json['shop_branch_id'] as int?,
      zoneId: json['zone_id'] as int?,
      riderId: json['rider_id'] as int?,
      deliveryAddress: json['delivery_address'] as String?,
      isDelivered: json['is_delivered'] as bool?,
      clientName: json["client_name"] as String?,
      branchName: json["shop_branch_name"] as String?);

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'shop_branch_id': shopBranchId,
        'zone_id': zoneId,
        'rider_id': riderId,
        'delivery_address': deliveryAddress,
        'is_delivered': isDelivered,
        "client_name": clientName,
        "shop_branch_name": branchName,
      };
}
