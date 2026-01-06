class CustomerDetailsModels {
  final Coupon coupon;
  final Customer customer;
  final Vehicle? vehicle;

  CustomerDetailsModels({
    required this.coupon,
    required this.customer,
    required this.vehicle,
  });

  factory CustomerDetailsModels.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModels(
      coupon: Coupon.fromJson(json['coupon']),
      customer: Customer.fromJson(json['customer']),
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
    );
  }
}

class Coupon {
  final String couponCode;
  final int discountPercent;
  final String status;
  final DateTime expiresAt;
  final bool isExpired;

  Coupon({
    required this.couponCode,
    required this.discountPercent,
    required this.status,
    required this.expiresAt,
    required this.isExpired,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json['coupon_code'],
      discountPercent: json['discount_percent'],
      status: json['status'],
      expiresAt: DateTime.parse(json['expires_at']),
      isExpired: json['is_expired'],
    );
  }
}

class Customer {
  final String name;
  final String phone;
  final String email;

  Customer({
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class Vehicle {
  final String number;
  final String make;
  final String model;
  final String type;

  Vehicle({
    required this.number,
    required this.make,
    required this.model,
    required this.type,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      number: json['number'],
      make: json['make'],
      model: json['model'],
      type: json['type'],
    );
  }
}
