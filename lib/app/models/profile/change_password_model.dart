class ChangePasswordModel {
  final bool success;
  final String message;
  final PartnerInfo? partner;

  ChangePasswordModel({
    required this.success,
    required this.message,
    this.partner,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      partner: json['partner'] != null
          ? PartnerInfo.fromJson(json['partner'])
          : null,
    );
  }
}

class PartnerInfo {
  final String id;
  final String partnerCode;
  final String companyName;
  final String ownerName;

  PartnerInfo({
    required this.id,
    required this.partnerCode,
    required this.companyName,
    required this.ownerName,
  });

  factory PartnerInfo.fromJson(Map<String, dynamic> json) {
    return PartnerInfo(
      id: json['id'],
      partnerCode: json['partner_code'],
      companyName: json['company_name'],
      ownerName: json['owner_name'],
    );
  }
}
