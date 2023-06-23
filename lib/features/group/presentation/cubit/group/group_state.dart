part of 'group_cubit.dart';

abstract class GroupState extends Equatable {
  const GroupState();
}

class GroupInitial extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupLoading extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupSuccess extends GroupState {
  final List<GroupEntity> groups;

  const GroupSuccess({
    required this.groups,
  });

  @override
  List<Object?> get props => [groups];
}

class GroupFailed extends GroupState {
  @override
  List<Object?> get props => [];
}
