import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../di/locator.dart';
import '../../../../network/network_info.dart';
import '../../../../themes/colors.dart';
import '../../../../themes/text_styles.dart';
import '../../../../widgets/buttons_widgets/app_elevated_button.dart';

/// Full-screen offline fallback for critical screens or cold-start network loss.
class InternetConnection extends StatefulWidget {
  static const String routeName = 'InternetConnection/';
  final NetworkInfo? networkInfo;

  const InternetConnection({super.key, this.networkInfo});

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  late final NetworkInfo _networkInfo =
      widget.networkInfo ?? locator<NetworkInfo>();
  late final StreamSubscription<bool> _listener;

  @override
  void initState() {
    super.initState();
    _listener = _networkInfo.onConnectivityChanged.listen((isConnected) {
      if (isConnected) {
        _pop();
      }
    });
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              Icons.wifi_off,
              size: 150,
              color: AppColors.primaryColor,
            ),
            Text(
              S.of(context).noInternetConnection,
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              S.of(context).checkConnection,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppElevatedButton(
                onPressed: _retryConnection,
                text: S.of(context).retry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _retryConnection() async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      _pop();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.stillNoInternetConnectionPleaseTryAgain),
          ),
        );
      }
    }
  }

  void _pop() {
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop(true);
    }
  }
}
