part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.apiState,
    required this.termsConfirmed,
    this.message,
    this.user,
  });
  final APIState apiState;
  final String? message;
  final bool termsConfirmed;
  final UserModel? user;
  @override
  List<Object?> get props => [apiState, message, termsConfirmed, user];
}
