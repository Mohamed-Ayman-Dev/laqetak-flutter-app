import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherHeader extends StatelessWidget {
  const SmartRefresherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
      waterDropColor: Theme.of(context).primaryColor,
      complete: Icon(Icons.check, color: Theme.of(context).primaryColor),
    );
  }
}
