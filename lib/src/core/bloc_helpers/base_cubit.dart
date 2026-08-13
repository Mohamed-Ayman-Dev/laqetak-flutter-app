import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/string_manager.dart';
import '../error/exceptions.dart';

abstract class BaseCubit<S> extends Cubit<S> {
  BaseCubit(super.initialState);

  // // ─── ?Prevent duplicate API calls ─────────────────────────────
  // bool _isLoading = false;
  //
  // Future<void> runOnce(Future<void> Function() action) async {
  //   if (_isLoading) return;
  //   _isLoading = true;
  //   try {
  //     await action();
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // ─── Error handling ──────────────────────────────────────────
  void handleError(Object e, void Function(String message) onError) {
    if (e is ApiException) {
      onError(e.message);
    } else {
      if (kDebugMode) print(e);
      // FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      onError(StringManager.somethingWentWrong);
    }
  }

  // ─── Safe emit + logging + Crashlytics ───────────────────────
  @override
  void emit(S state) {
    if (!isClosed) {
      // if (kDebugMode) print('${runtimeType} → ${state.runtimeType}');
      // FirebaseCrashlytics.instance.log('${runtimeType}: ${state.runtimeType}');
      super.emit(state);
    }
  }
}
