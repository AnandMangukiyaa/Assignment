part of 'user_bloc.dart';

class UserState extends Equatable {
  final ResultStatus status;
  final List<UserData?> users;
  final String message;

  const UserState({
    this.status = ResultStatus.none,
    this.users = const [],
    this.message = '',
  });

  UserState update({
    ResultStatus? status,
    List<UserData>? users,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, users ?? [], message];
}
