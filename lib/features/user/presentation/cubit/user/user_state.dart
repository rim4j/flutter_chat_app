part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSuccess extends UserState {
  final List<UserEntity> users;

  const UserSuccess({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class UserFailed extends UserState {
  @override
  List<Object?> get props => [];
}
