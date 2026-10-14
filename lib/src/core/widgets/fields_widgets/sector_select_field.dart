import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';

import '../../../../generated/l10n.dart';
import '../../shared/others/data/models/sector_model.dart';
import '../../themes/colors.dart';
import 'custom_drop_down_menu.dart';

class SectorSelectField extends StatefulWidget {
  final List<SectorModel>? sectors;
  final Map<String, dynamic> formData;
  final TextEditingController? otherController;

  const SectorSelectField({
    super.key,
    required this.sectors,
    required this.formData,
    this.otherController,
  });

  @override
  State<SectorSelectField> createState() => _SectorSelectFieldState();
}

class _SectorSelectFieldState extends State<SectorSelectField> {
  bool _requiresAdditionalInfo = false;

  // ← single source of truth for all borders
  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12).r,
    borderSide: BorderSide(color: AppColors.borderColor, width: 1),
  );

  @override
  void initState() {
    super.initState();
    if (widget.otherController?.text.isNotEmpty ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _requiresAdditionalInfo = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownFormField<SectorModel>(
          hint: S.of(context).selectSector,
          items: widget.sectors,
          itemAsString: (item) => item.name ?? '',
          value: widget.formData['sector_id'] == null
              ? null
              : widget.sectors?.firstWhere(
                  (e) => e.id == widget.formData['sector_id'],
                  orElse: () => SectorModel(),
                ),
          validator: (value) {
            if (value == null) {
              return S.of(context).pleaseSelectASector;
            }
            // if ((value.requiresAdditionalInfo ?? false) &&
            //     _otherController.text.trim().isEmpty) {
            //   return S.of(context).pleaseSpecifyTheSector;
            // }
            return null;
          },
          onChanged: (val) {
            setState(() {
              _requiresAdditionalInfo = val?.requiresAdditionalInfo ?? false;
            });

            widget.formData['sector_id'] = val?.id;
            widget.formData['requires_additional_info'] =
                _requiresAdditionalInfo;

            if (_requiresAdditionalInfo) {
              widget.formData['sector_additional_info'] =
                  widget.otherController?.text;
            } else {
              widget.formData.remove('sector_additional_info');
              widget.otherController?.clear();
            }
          },
          onSaved: (val) {},
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 280),
          sizeCurve: Curves.easeInOut,
          firstCurve: Curves.easeOut,
          secondCurve: Curves.easeIn,
          crossFadeState: _requiresAdditionalInfo
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity, height: 0),
          secondChild: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: TextFormField(
              controller: widget.otherController,

              decoration: InputDecoration(
                fillColor: Colors.white,
                hintStyle: AppTextStyles.hintTextStyle.copyWith(
                  fontSize: 12.sp,
                ),
                filled: true,
                hintText: S.of(context).enterSectorName,
                border: _border(AppColors.inputBorderColor),
                enabledBorder: _border(AppColors.inputBorderColor),
                focusedBorder: _border(AppColors.primaryColor),
                errorBorder: _border(AppColors.errorTextColor),
                focusedErrorBorder: _border(AppColors.errorTextColor),
              ),
              maxLines: 2,
              validator: (val) {
                if (_requiresAdditionalInfo &&
                    (val == null || val.trim().isEmpty)) {
                  return S.of(context).pleaseEnterSectorName;
                }
                return null;
              },
              onChanged: (val) {
                widget.formData['sector_additional_info'] = val;
              },
            ),
          ),
        ),
      ],
    );
  }
}
