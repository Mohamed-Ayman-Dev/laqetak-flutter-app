import 'package:equatable/equatable.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';

import '../../../../core/constants/enums.dart';

class AuthState extends Equatable {
  final RequestState authState;
  final String? errorMessage;
  final String? loadingMessage;
  final UserModel? user;
  final String? token;
  final String? refreshToken;

  const AuthState({
    this.authState = RequestState.initial,
    this.errorMessage,
    this.loadingMessage,
    this.user,
    this.token,
    this.refreshToken,
  });

  AuthState copyWith({
    RequestState? authState,
    String? errorMessage,
    String? loadingMessage,
    UserModel? user,
    String? token,
    String? refreshToken,
  }) {
    return AuthState(
      authState: authState ?? this.authState,
      errorMessage: errorMessage ?? this.errorMessage,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      user: user ?? this.user,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    authState,
    loadingMessage,
    user,
    token,
    refreshToken,
  ];
}
