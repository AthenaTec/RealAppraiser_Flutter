import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';

class SecurityTokenModel extends SecurityTokenEntity {
  const SecurityTokenModel({
    required super.accessToken,
    required super.tokenType,
    required super.expiresIn,
  });

  factory SecurityTokenModel.fromJson(Map<String, dynamic> json) =>
      SecurityTokenModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );
}
