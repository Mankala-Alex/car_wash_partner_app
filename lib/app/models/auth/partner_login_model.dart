class PartnerLoginModel {
  final bool success;
  final PartnerData partner;
  final String token;

  PartnerLoginModel({
    required this.success,
    required this.partner,
    required this.token,
  });

  factory PartnerLoginModel.fromJson(Map<String, dynamic> json) {
    return PartnerLoginModel(
      success: json['success'] ?? false,
      partner: PartnerData.fromJson(json['partner'] ?? {}),
      token: json['token'] ?? '',
    );
  }
}

class PartnerData {
  final String id;
  final String partnerCode;
  final String companyName;
  final String ownerName;
  final String status;
  final String? imageUrl;
  final String? city;
  final String? district;
  final String? country;

  PartnerData({
    required this.id,
    required this.partnerCode,
    required this.companyName,
    required this.ownerName,
    required this.status,
    this.imageUrl,
    this.city,
    this.district,
    this.country,
  });

  factory PartnerData.fromJson(Map<String, dynamic> json) {
    return PartnerData(
      id: json['id'] ?? '',
      partnerCode: json['partner_code'] ?? '',
      companyName: json['company_name'] ?? '',
      ownerName: json['owner_name'] ?? '',
      status: json['status'] ?? '',
      imageUrl: json['image_url'],
      city: json['city'],
      district: json['district'],
      country: json['country'],
    );
  }
}
