part of 'single_user_cubit.dart';

abstract class SingleUserState extends Equatable {
  const SingleUserState();
}

class SingleUserInitial extends SingleUserState {
  @override
  List<Object?> get props => [];
}

class SingleUserLoading extends SingleUserState {
  @override
  List<Object?> get props => [];
}

class SingleUserSuccess extends SingleUserState {
  final UserEntity currentUser;

  const SingleUserSuccess({required this.currentUser});

  @override
  List<Object?> get props => [currentUser];
}

class SingleUserFailed extends SingleUserState {
  @override
  List<Object?> get props => [];
}
