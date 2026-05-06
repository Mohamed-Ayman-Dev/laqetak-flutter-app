import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';

import '../../../../../generated/l10n.dart';
import '../../domain/usecases/login_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  final LoginUseCase _loginUseCase;

  AuthCubit(this._loginUseCase) : super(const AuthState());

  Future<void> login(Map<String, dynamic> data) async {
    AppFeedback.loadingMessage();
    final result = await _loginUseCase(data);
    result.when(
      success: (data) async {
        AppFeedback.successToast(
          data?['message'] ?? S.current.youLoggedInSuccessfully,
        );
      },
      failure: (error) {
        AppFeedback.errorMessage(error);
        final redirect = error.data?['data']?['redirect'];
        if (redirect == 'register-otp') {
          // LocatorService.navigationService.currentState?.pushNamed(
          //   OtpScreen.routeName,
          //   arguments: {
          //     'phone': data['phone'],
          //     'country_code': data['country_code'],
          //     'from': "login_screen",
          //     'remainingSeconds': error.data['data']['remainingSeconds'],
          //   },
          // );
        }
      },
    );
  }
}
