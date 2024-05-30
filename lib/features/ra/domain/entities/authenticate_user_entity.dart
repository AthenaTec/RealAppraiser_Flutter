import 'package:equatable/equatable.dart';

class AuthenticateUserEntity extends Equatable {
  final int status;
  final AuthenticateUserDataEntity data;
  final String msg;

  const AuthenticateUserEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class AuthenticateUserDataEntity extends Equatable {
  final bool isPrivacyPolicyAccepted;
  final bool isMain;
  final int isExternal;
  final int active;
  final String otp;
  final bool isPwdExpired;
  final String email;
  final int loginId;
  final int employeeId;
  final String firstName;
  final String lastName;
  final dynamic mobile;
  final int agencyId;
  final int branchId;
  final String agencyName;
  final String cityName;
  final dynamic agencyCode;
  final List<AuthenticateUserRoleEntity> roles;

  const AuthenticateUserDataEntity({
    required this.isPrivacyPolicyAccepted,
    required this.isMain,
    required this.isExternal,
    required this.active,
    required this.otp,
    required this.isPwdExpired,
    required this.email,
    required this.loginId,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.agencyId,
    required this.branchId,
    required this.agencyName,
    required this.cityName,
    required this.agencyCode,
    required this.roles,
  });

  @override
  List<Object?> get props => [
        isPrivacyPolicyAccepted,
        isMain,
        isExternal,
        active,
        otp,
        isPwdExpired,
        email,
        loginId,
        employeeId,
        firstName,
        lastName,
        mobile,
        agencyId,
        branchId,
        agencyName,
        cityName,
        agencyCode,
        roles,
      ];
}

class AuthenticateUserRoleEntity extends Equatable {
  final int roleId;
  final String roleDescription;

  const AuthenticateUserRoleEntity({
    required this.roleId,
    required this.roleDescription,
  });

  @override
  List<Object?> get props => [roleId, roleDescription];
}
