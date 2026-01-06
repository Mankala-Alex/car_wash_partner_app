class RedeemCouponModel {
  final bool success;
  final RedeemCouponData? data;
  final String? message;

  RedeemCouponModel({
    required this.success,
    this.data,
    this.message,
  });

  factory RedeemCouponModel.fromJson(Map<String, dynamic> json) {
    return RedeemCouponModel(
      success: json['success'] ?? false,
      message: json['message'],
      data:
          json['data'] != null ? RedeemCouponData.fromJson(json['data']) : null,
    );
  }
}

class RedeemCouponData {
  final String couponCode;
  final String status;
  final int discountPercent;
  final DateTime usedAt;

  RedeemCouponData({
    required this.couponCode,
    required this.status,
    required this.discountPercent,
    required this.usedAt,
  });

  factory RedeemCouponData.fromJson(Map<String, dynamic> json) {
    return RedeemCouponData(
      couponCode: json['coupon_code'],
      status: json['status'],
      discountPercent: json['discount_percent'],
      usedAt: DateTime.parse(json['used_at']),
    );
  }
}
