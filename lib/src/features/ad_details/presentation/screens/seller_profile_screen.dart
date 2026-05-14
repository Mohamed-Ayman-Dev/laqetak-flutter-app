import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/features/ad_details/presentation/widgets/ad_details_header.dart';

class SellerProfileScreen extends StatefulWidget {
  static const routeName = '/seller_profile_screen';

  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AdDetailsHeader()],
            ),
          ),
        ],
      ),
    );
  }
}
