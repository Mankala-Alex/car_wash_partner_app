class ValidateCouponModel {
  final bool success;
  final String? message;
  final ValidateCouponData? data;

  ValidateCouponModel({
    required this.success,
    this.message,
    this.data,
  });

  factory ValidateCouponModel.fromJson(Map<String, dynamic> json) {
    return ValidateCouponModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null
          ? ValidateCouponData.fromJson(json['data'])
          : null,
    );
  }
}

class ValidateCouponData {
  final String couponCode;
  final int discountPercent;
  final String bookingCode;
  final String customerId;

  ValidateCouponData({
    required this.couponCode,
    required this.discountPercent,
    required this.bookingCode,
    required this.customerId,
  });

  factory ValidateCouponData.fromJson(Map<String, dynamic> json) {
    return ValidateCouponData(
      couponCode: json['coupon_code'],
      discountPercent: json['discount_percent'],
      bookingCode: json['booking_code'],
      customerId: json['customer_id'],
    );
  }
}
