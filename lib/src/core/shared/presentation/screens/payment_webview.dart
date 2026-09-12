import 'dart:async'; // 👈 import this

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../generated/l10n.dart';

class PaymentWebView extends StatefulWidget {
  static const routeName = '/payment-webview';

  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  late Timer _timeoutTimer;
  late Timer _countdownTimer;
  int _secondsLeft = 600;
  String initialUrl = '';
  bool _hasPopped = false;
  String? orderId;
  String? timeInMinutes;

  void _startTimers(int minutes) {
    _secondsLeft = minutes * 60;
    _timeoutTimer = Timer(Duration(minutes: minutes), () {
      if (!_hasPopped) {
        _hasPopped = true;
        print("Timeout reached. Closing payment screen.");
        EasyLoading.showToast(S.of(context).timeoutReachedClosingPaymentScreen);
        Navigator.of(context).pop(false);
      }
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _countdownTimer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            if (kDebugMode) {
              print(
                '--------------------------------Navigating to: ${request.url}',
              );
            }
            if (_hasPopped) return NavigationDecision.prevent;

            final url = request.url;
            if (url.contains('myfatoorah/api-result')) {
              _hasPopped = true;
              final params = Uri.parse(url).queryParameters;
              paymentStatus = params['payment_status'] == 'paid';
              Navigator.of(context).pop(paymentStatus);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  void dispose() {
    _timeoutTimer.cancel();
    _countdownTimer.cancel();
    super.dispose();
  }

  bool once = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        initialUrl = args['initialUrl'] ?? '';
        orderId = args['orderId'].toString();
        timeInMinutes = args['time'];
        _controller.loadRequest(Uri.parse(initialUrl));
        final int minutes =
            int.tryParse(timeInMinutes ?? '') ??
            10; // fallback to 10 if null/invalid
        _startTimers(minutes);
      }
      once = true;
    }
  }

  bool paymentStatus = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (orderId != null) {
          try {
            ///1 -check if the payment success by navigate to the success page in webview
            ///if true back with ( true ) means back with payment success
            if (paymentStatus) {
              _hasPopped = true;
              Navigator.of(context).pop(true);
              return false;
            }

            ///3 -if the first 2 cases failed means the payment is really failed
            ///in that case send to backend that the user will back from the payment screen and the payment is failed
            _hasPopped = true;
            Navigator.of(context).pop(false);
            return false;
          } catch (e) {
            ///if anything else go wrong go back from the payment screen and send to the back that the payment is failed
            _hasPopped = true;
            Navigator.of(context).pop(false);
            return false;
          }
        }
        return true; // only if not order
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).paymentGateway),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' $_secondsLeft ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: S.of(context).s,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
