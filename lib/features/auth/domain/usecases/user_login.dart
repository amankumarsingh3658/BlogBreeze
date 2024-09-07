import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/Repository/auth_repository.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';


class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  String email;
  String password;
  UserLoginParams({required this.email, required this.password});
}
