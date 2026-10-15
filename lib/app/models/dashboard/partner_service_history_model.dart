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
  final String paymentStatus;
  final DateTime? paidAt;
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
    required this.paymentStatus,
    required this.paidAt,
    required this.createdAt,
  });

  factory PartnerServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    return PartnerServiceHistoryModel(
      id: json['id'],
      serviceName: json['service_name'],
      couponCode: json['coupon_code'],
      originalAmount: double.parse(json['original_amount'].toString()),
      finalAmount: double.parse(json['final_amount'].toString()),
      adminPayable: double.parse(json['admin_payable'].toString()),
      discountPercent: int.parse(json['discount_percent'].toString()),
      customerName: json['customer_name'] ?? "N/A",
      vehicleNumber: json['vehicle_number'] ?? "N/A",
      paymentStatus: json['payment_status'] ?? "",
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
