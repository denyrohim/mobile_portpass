import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser implements UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) async =>
      _repository.updateUser(
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
      : this(
          action: UpdateUserAction.name,
          userData: 'name',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
