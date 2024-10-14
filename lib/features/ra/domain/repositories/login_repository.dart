import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/login_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';

import '../entities/employee_branch_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> submitUrl(String url);

  Future<Either<Failure, GetStoreEntity>> getStore(String email , BuildContext c);

  Future<Either<Failure, AuthenticateUserEntity>> authenticateUser(
      String email, String password,BuildContext c);

  Future<Either<Failure, SecurityTokenEntity>> securityToken(
      String email, String password,BuildContext c);
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch(BuildContext c);

}
