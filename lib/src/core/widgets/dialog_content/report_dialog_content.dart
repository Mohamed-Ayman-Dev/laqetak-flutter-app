import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/core/widgets/fields_widgets/custom_note_field.dart';

import '../../../../generated/l10n.dart';
import '../../constants/svg_assets.dart';
import '../../extension/space_extensions_helper.dart';
import '../buttons_widgets/custom_elevated_button.dart';

class ReportDialogContent extends StatefulWidget {
  final num id;
  final bool isCustomerReport;

  const ReportDialogContent({
    super.key,
    required this.id,
    this.isCustomerReport = false,
  });

  @override
  State<ReportDialogContent> createState() => _ReportDialogContentState();
}

class _ReportDialogContentState extends State<ReportDialogContent> {
  final _formKey = GlobalKey<FormState>();
  late final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context);
      widget.isCustomerReport
          ? LocatorService.adsCubit.sendCustomerComplaint({
              'customer_id': widget.id,
              'reason': _reasonController.text,
            })
          : LocatorService.adsCubit.sendAdComplaint({
              'ad_id': widget.id,
              'reason': _reasonController.text,
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 41, 27, 44).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).enterTheReportReason,
              style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
            ),
            10.heightSpace,

            // ─── Subtitle ───
            Form(
              key: _formKey,
              child: CustomNoteField(
                hint: S.of(context).writeTheReason,
                controller: _reasonController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return S.of(context).pleaseEnterComplaintDetails;
                  }
                  return null;
                },
              ),
            ),
            24.heightSpace,

            // ─── Button ───
            CustomElevatedButton(
              text: S.of(context).send,
              icon: SvgAssets.assetsSvgArrowRight,
              size: Size(163.w, 48.h),
              onPressed: _send,
            ),
          ],
        ),
      ),
    );
  }
}
