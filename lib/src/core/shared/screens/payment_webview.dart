import 'dart:async'; // 👈 import this

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../generated/l10n.dart';

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
  String _deviceModel = "Unknown Device";

  // /// Fetch device model once and store
  // Future<void> _getDeviceModel() async {
  //   final deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     final androidInfo = await deviceInfo.androidInfo;
  //     _deviceModel = "${androidInfo.brand} ${androidInfo.model}";
  //   } else if (Platform.isIOS) {
  //     final iosInfo = await deviceInfo.iosInfo;
  //     _deviceModel = iosInfo.utsname.machine ?? "Unknown iPhone";
  //   } else {
  //     _deviceModel = "Unknown Device";
  //   }
  // }

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
            print(
              '--------------------------------Navigating to: ${request.url}',
            );
            if (_hasPopped) return NavigationDecision.prevent;
            // final now = DateTime.now();
            // final formattedDate = DateFormat('yyyy-MM-dd', 'en').format(now);
            // final formattedTime = DateFormat('HH:mm:ss', 'en').format(now);
            //
            // await LocatorService.ordersService.sendPayLog(
            //   queryParameters: {
            //     'id': orderId,
            //     'url': request.url,
            //     'test':
            //         'UserPaymentGatewaySteps-deviceData:$_deviceModel-nextUrl:$initialUrl- date:$formattedDate time:$formattedTime',
            //   },
            // );
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

  // Future<void> _handlePaymentCallback(String url) async {
  //   try {
  //     final response = await ApiService.get(url);
  //     // أو Dio() عادي لو الـ endpoint ده مش تحت نفس الـ base/interceptors بتاعتك
  //
  //     final data = response.data is String
  //         ? jsonDecode(response.data)
  //         : response
  //         .data; // Dio أحياناً بيعمل parse تلقائي لو الـ content-type JSON
  //
  //     final bool isSuccess = data['status'] == true;
  //
  //     if (mounted) {
  //       paymentStatus = isSuccess;
  //       Navigator.of(context).pop(paymentStatus);
  //     }
  //   } catch (e) {
  //     debugPrint('Payment callback fetch failed: $e');
  //     if (mounted) {
  //       paymentStatus = false;
  //       Navigator.of(context).pop(false);
  //     }
  //   }
  // }
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
        // Future.microtask(() async {
        //   await _getDeviceModel();
        //   final now = DateTime.now();
        //   final formattedDate = DateFormat('yyyy-MM-dd', 'en').format(now);
        //   final formattedTime = DateFormat('HH:mm:ss', 'en').format(now);
        //
        //   await LocatorService.ordersService.sendPayLog(
        //     queryParameters: {
        //       'id': orderId,
        //       'url': initialUrl,
        //       'test':
        //           'UserPaymentGatewaySteps-deviceData:$_deviceModel-initurl:$initialUrl date:$formattedDate time:$formattedTime',
        //     },
        //   );
        //   print(" First log sent with deviceModel=$_deviceModel");
        // });
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

            ///2 -if not success in the first case ( webview didnt navigate to success page )
            ///send a check payment status to the backend to check again if the payment is success or not using the check endpoint instead of navigate to the success page
            ///if true back with ( true ) means back with payment success
            // EasyLoading.show(status: S.of(context).pleaseWait);
            // final status = await LocatorService.ordersService.checkPayment(
            //   orderNum: orderId!,
            // );
            // EasyLoading.dismiss();
            // if (status['data']['status'].toString().toLowerCase() == ('paid')) {
            //   paymentStatus = true;
            //   _hasPopped = true;
            //   Navigator.of(context).pop(true);
            //   return false;
            // }

            ///3 -if the first 2 cases failed means the payment is really failed
            ///in that case send to backend that the user will back from the payment screen and the payment is failed
            //  Pending or failed
            // await LocatorService.ordersService.cancelPayment(
            //   orderNum: orderId!,
            // );
            _hasPopped = true;
            Navigator.of(context).pop(false);
            return false;
          } catch (e) {
            ///if anything else go wrong go back from the payment screen and send to the back that the payment is failed
            // await LocatorService.ordersService.cancelPayment(
            //   orderNum: orderId!,
            // );
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
                          color: Colors
                              .black, // or Theme.of(context).textTheme.bodyLarge?.color
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
