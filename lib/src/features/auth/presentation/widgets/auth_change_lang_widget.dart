import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthChangeLangWidget extends StatefulWidget {
  const AuthChangeLangWidget({super.key});

  @override
  State<AuthChangeLangWidget> createState() => _AuthChangeLangWidgetState();
}

class _AuthChangeLangWidgetState extends State<AuthChangeLangWidget> {
  double paddingBottom = 75;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(37, 69, 37, paddingBottom).r,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTitleWidget(title: S.current.chooseLanguage),
          // 50.heightSpace,
          // const LanguageSectionWidget(),
        ],
      ),
    );
  }
}
