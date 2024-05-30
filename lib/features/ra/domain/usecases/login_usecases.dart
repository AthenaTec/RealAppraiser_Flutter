import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/login_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/login_repository.dart';

class LoginUseCases {
  final LoginRepository loginRepository;

  LoginUseCases({required this.loginRepository});

  Future<Either<Failure, LoginEntity>> submitUrl(String url) {
    return loginRepository.submitUrl(url);
  }

  Future<Either<Failure, GetStoreEntity>> getStore(String email) {
    return loginRepository.getStore(email);
  }

  Future<Either<Failure, AuthenticateUserEntity>> authenticateUser(String email,String password) {
    return loginRepository.authenticateUser(email,password);
  }

  Future<Either<Failure, SecurityTokenEntity>>securityToken (String email,String password) {
    return loginRepository.securityToken(email,password);
  }
}
