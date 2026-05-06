import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';

class AuthState extends Equatable {
  final RequestState authState;
  final String? errorMessage;
  final String? loadingMessage;

  const AuthState({
    this.authState = RequestState.initial,
    this.errorMessage,
    this.loadingMessage,
  });

  AuthState copyWith({
    RequestState? authState,
    String? errorMessage,
    String? loadingMessage,
  }) {
    return AuthState(
      authState: authState ?? this.authState,
      errorMessage: errorMessage,
      loadingMessage: loadingMessage,
    );
  }

  @override
  List<Object?> get props => [errorMessage, authState, loadingMessage];
}
