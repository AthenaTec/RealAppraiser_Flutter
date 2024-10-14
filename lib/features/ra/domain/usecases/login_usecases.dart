import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/login_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/login_repository.dart';

import '../entities/employee_branch_entity.dart';

class LoginUseCases {
  final LoginRepository loginRepository;

  LoginUseCases({required this.loginRepository});

  Future<Either<Failure, LoginEntity>> submitUrl(String url) {
    return loginRepository.submitUrl(url);
  }

  Future<Either<Failure, GetStoreEntity>> getStore(String email,BuildContext c) {
    return loginRepository.getStore(email,c);
  }

  Future<Either<Failure, AuthenticateUserEntity>> authenticateUser(String email,String password,BuildContext c) {
    return loginRepository.authenticateUser(email,password,c);
  }

  Future<Either<Failure, SecurityTokenEntity>>securityToken (String email,String password,BuildContext c) {
    return loginRepository.securityToken(email,password,c);
  }
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch(BuildContext c) {
    return loginRepository.getEmployeeBranch(c);
  }

}
