import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../generated/l10n.dart';
import '../widgets/buttons_widgets/custom_elevated_button.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';

/// continue here later
class InternetConnection extends StatefulWidget {
  static const String routeName = 'InternetConnection/';
  final InternetConnectionChecker internetConnectionChecker;

  const InternetConnection({
    super.key,
    required this.internetConnectionChecker,
  });

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void initState() {
    super.initState();

    listener = widget.internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          _pop();
          break;
        case InternetConnectionStatus.disconnected:
          break;
        case InternetConnectionStatus.slow:
          break;
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();

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
              child: CustomElevatedButton(
                onPressed: _retryConnection,
                text: S.of(context).retry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _retryConnection() {
    widget.internetConnectionChecker.hasConnection.then((isConnected) {
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
    });
  }

  void _pop() {
    Navigator.of(context).pop(true);
  }
}
