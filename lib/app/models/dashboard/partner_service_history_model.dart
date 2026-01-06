class PartnerServiceHistoryModel {
  final String id;
  final String serviceName;
  final String couponCode;
  final double originalAmount;
  final double finalAmount;
  final double adminPayable;
  final int discountPercent;
  final String customerName;
  final String vehicleNumber;
  final DateTime createdAt;

  PartnerServiceHistoryModel({
    required this.id,
    required this.serviceName,
    required this.couponCode,
    required this.originalAmount,
    required this.finalAmount,
    required this.adminPayable,
    required this.discountPercent,
    required this.customerName,
    required this.vehicleNumber,
    required this.createdAt,
  });

  factory PartnerServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    return PartnerServiceHistoryModel(
      id: json['id'],
      serviceName: json['service_name'],
      couponCode: json['coupon_code'],
      originalAmount: double.parse(json['original_amount']),
      finalAmount: double.parse(json['final_amount']),
      adminPayable: double.parse(json['admin_payable']),
      discountPercent: json['discount_percent'],
      customerName: json['customer_name'] ?? "N/A",
      vehicleNumber: json['vehicle_number'] ?? "N/A",
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
