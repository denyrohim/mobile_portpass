import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser implements UsecaseWithParams<LocalUser, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(UpdateUserParams params) => _repository.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : action = UpdateUserAction.email,
        userData = const LocalUser.empty();

  final UpdateUserAction action;
  final LocalUser userData;
  
  @override
  List<Object?> get props => [action, userData];
}
