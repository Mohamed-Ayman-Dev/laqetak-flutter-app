import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/network_info.dart';
import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _subscription;
  Timer? _restoredTimer;

  NetworkCubit(this._networkInfo) : super(const NetworkState()) {
    _init();
  }

  void _init() async {
    // Listen to OS-level connectivity change stream
    _subscription = _networkInfo.onConnectivityChanged.listen((isConnected) {
      if (isConnected) {
        markConnected();
      } else {
        markDisconnected();
      }
    });

    // Check initial connectivity in background
    final connected = await _networkInfo.isConnected;
    if (!connected && !isClosed) {
      markDisconnected();
    } else if (connected && !isClosed && state.isDisconnected) {
      markConnected();
    }
  }

  /// Called whenever a real network request succeeds or connection is detected.
  void markConnected() {
    _restoredTimer?.cancel();
    if (state.wasDisconnected) {
      emit(
        state.copyWith(
          status: NetworkStatus.connected,
          justRestored: true,
        ),
      );
      _restoredTimer = Timer(const Duration(seconds: 3), () {
        if (!isClosed && state.isConnected) {
          emit(
            state.copyWith(
              justRestored: false,
              wasDisconnected: false,
            ),
          );
        }
      });
    } else if (state.isDisconnected) {
      emit(
        state.copyWith(
          status: NetworkStatus.connected,
          justRestored: false,
        ),
      );
    }
  }

  /// Called when a network failure occurs or connection is lost.
  void markDisconnected() {
    _restoredTimer?.cancel();
    if (!state.isDisconnected) {
      emit(
        state.copyWith(
          status: NetworkStatus.disconnected,
          wasDisconnected: true,
          justRestored: false,
        ),
      );
    }
  }

  /// Manually trigger a connectivity check (useful for Retry buttons)
  Future<bool> checkConnection() async {
    final connected = await _networkInfo.isConnected;
    if (connected) {
      markConnected();
    } else {
      markDisconnected();
    }
    return connected;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _restoredTimer?.cancel();
    return super.close();
  }
}
