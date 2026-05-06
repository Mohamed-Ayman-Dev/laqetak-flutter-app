import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/string_manager.dart';
import '../error/exceptions.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

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
}
