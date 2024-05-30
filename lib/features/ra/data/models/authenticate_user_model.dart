import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';

class AuthenticateUserModel extends AuthenticateUserEntity {
  const AuthenticateUserModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory AuthenticateUserModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateUserModel(
        status: json["status"],
        data: AuthenticateUserDataModel.fromJson(json["data"]),
        msg: json["msg"],
      );
}

class AuthenticateUserDataModel extends AuthenticateUserDataEntity {
  const AuthenticateUserDataModel({
    required super.isPrivacyPolicyAccepted,
    required super.isMain,
    required super.isExternal,
    required super.active,
    required super.otp,
    required super.isPwdExpired,
    required super.email,
    required super.loginId,
    required super.employeeId,
    required super.firstName,
    required super.lastName,
    required super.mobile,
    required super.agencyId,
    required super.branchId,
    required super.agencyName,
    required super.cityName,
    required super.agencyCode,
    required super.roles,
  });

  factory AuthenticateUserDataModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateUserDataModel(
        isPrivacyPolicyAccepted: json["IsPrivacyPolicyAccepted"],
        isMain: json["IsMain"],
        isExternal: json["IsExternal"],
        active: json["Active"],
        otp: json["OTP"],
        isPwdExpired: json["IsPwdExpired"],
        email: json["Email"],
        loginId: json["LoginId"],
        employeeId: json["EmployeeId"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        mobile: json["Mobile"],
        agencyId: json["AgencyId"],
        branchId: json["BranchId"],
        agencyName: json["AgencyName"],
        cityName: json["CityName"],
        agencyCode: json["AgencyCode"],
        roles: List<AuthenticateUserRoleModel>.from(
            json["Roles"].map((x) => AuthenticateUserRoleModel.fromJson(x))),
      );
}

class AuthenticateUserRoleModel extends AuthenticateUserRoleEntity {
  const AuthenticateUserRoleModel({
    required super.roleId,
    required super.roleDescription,
  });

  factory AuthenticateUserRoleModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateUserRoleModel(
        roleId: json["RoleId"],
        roleDescription: json["RoleDescription"],
      );
}
