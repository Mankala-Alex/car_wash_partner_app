class AllServicesModel {
  final String id;
  final String partnerId;
  final String serviceName;
  final String? description;
  final double price;
  final bool isActive;

  AllServicesModel({
    required this.id,
    required this.partnerId,
    required this.serviceName,
    this.description,
    required this.price,
    required this.isActive,
  });

  factory AllServicesModel.fromJson(Map<String, dynamic> json) {
    return AllServicesModel(
      id: json['id'],
      partnerId: json['partner_id'],
      serviceName: json['service_name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      isActive: json['is_active'],
    );
  }
}
