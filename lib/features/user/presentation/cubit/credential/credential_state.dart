part of 'credential_cubit.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  List<Object?> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  List<Object?> get props => [];
}

class CredentialSuccess extends CredentialState {
  @override
  List<Object?> get props => [];
}

class CredentialFailed extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GoogleCredentialLoading extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GoogleCredentialSuccess extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GoogleCredentialFailed extends CredentialState {
  @override
  List<Object?> get props => [];
}
