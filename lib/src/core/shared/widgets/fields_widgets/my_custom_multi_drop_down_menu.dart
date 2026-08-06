import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../themes/text_styles.dart';
import '../../../themes/theme.dart';

class MyCustomMultiDropdownFormField<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemAsString;
  final bool Function(T, T)? compareFn;
  final void Function(List<T>)? onChanged;
  final bool isRequired;
  final Color? color;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final String? hint;
  final double borderRadius;
  final bool isLoading;

  const MyCustomMultiDropdownFormField({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.itemAsString,
    this.compareFn,
    this.onChanged,
    this.isLoading = false,
    this.enabled = true,
    this.contentPadding,
    this.borderRadius = 12,
    this.borderColor,
    this.hint,
    this.isRequired = false,
    this.color,
  });

  @override
  State<MyCustomMultiDropdownFormField<T>> createState() =>
      _MyCustomMultiDropdownFormFieldState<T>();
}

class _MyCustomMultiDropdownFormFieldState<T>
    extends State<MyCustomMultiDropdownFormField<T>> {
  // ← بيتعمل مرة واحدة بس هنا، مش في كل build
  final GlobalKey<DropdownSearchState<T>> _dropdownKey =
      GlobalKey<DropdownSearchState<T>>();

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius).r,
    borderSide: BorderSide(color: widget.borderColor ?? color, width: 1),
  );

  bool _isEqual(T a, T b) => widget.compareFn?.call(a, b) ?? a == b;

  @override
  Widget build(BuildContext context) {
    final bool dropEnabled = widget.items.isNotEmpty && widget.enabled;
    final T allItem = widget.items.first;

    return Theme(
      data: CustomTheme.lightTheme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: DropdownSearch<T>.multiSelection(
        key: _dropdownKey,
        items: widget.items,
        enabled: dropEnabled,
        selectedItems: widget.selectedItems,
        itemAsString: widget.itemAsString,
        compareFn: widget.compareFn,
        onChanged: widget.onChanged,

        dropdownBuilder: (context, selected) {
          final text = selected.isEmpty
              ? (widget.hint ?? '')
              : selected.map(widget.itemAsString).join(', ');
          return Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: selected.isEmpty
                ? AppTextStyles.hintTextStyle
                : Theme.of(context).textTheme.bodyMedium,
          );
        },

        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          fit: FlexFit.loose,

          onItemAdded: (currentSelected, addedItem) {
            final addedIsAll = _isEqual(addedItem, allItem);

            if (addedIsAll) {
              final othersToRemove = currentSelected
                  .where((e) => !_isEqual(e, allItem))
                  .toList();
              if (othersToRemove.isNotEmpty) {
                _dropdownKey.currentState?.popupDeselectItems(othersToRemove);
              }
            } else {
              final allIsSelected = currentSelected.any(
                (e) => _isEqual(e, allItem),
              );
              if (allIsSelected) {
                _dropdownKey.currentState?.popupDeselectItems([allItem]);
              }
            }
          },

          validationWidgetBuilder: (context, selectedItems) {
            return Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14).r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onChanged?.call(selectedItems);
                  },
                  child: Text(
                    S.of(context).apply,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },

          searchDelay: Duration.zero,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: S.of(context).search,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ).r,
              border: _border(AppColors.fieldBorderColor),
              enabledBorder: _border(AppColors.fieldBorderColor),
              focusedBorder: _border(AppColors.primaryColor),
              errorBorder: _border(AppColors.errorTextColor),
              focusedErrorBorder: _border(AppColors.errorTextColor),
            ),
          ),
          containerBuilder: (context, popupWidget) {
            return Container(
              margin: EdgeInsets.only(top: 10).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: popupWidget,
            );
          },
          selectionWidget: (context, item, isSelected) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
            child: Checkbox(
              value: isSelected,
              side: BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: isSelected
                  ? WidgetStatePropertyAll(AppColors.primaryColor)
                  : WidgetStatePropertyAll(Colors.white),
              activeColor: AppColors.primaryColor,
              onChanged: null,
            ),
          ),

          itemBuilder: (context, item, isSelected) {
            final isFirstItem =
                widget.items.isNotEmpty &&
                (widget.compareFn?.call(item, widget.items.first) ??
                    item == widget.items.first);

            return Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withOpacity(0.06)
                    : null,
                border: isFirstItem
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      )
                    : null,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.itemAsString(item),
                      overflow: TextOverflow.ellipsis,
                      style: isFirstItem
                          ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                          : Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              minWidth: 3.w,
              minHeight: 3.h,
            ),
            prefixIcon: widget.isRequired
                ? Padding(
                    padding: EdgeInsets.only(right: 10.0).r,
                    child: Text('*', style: TextStyle(color: Colors.red)),
                  )
                : null,
            enabled: dropEnabled,
            hintText: widget.hint,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 13).r,
            fillColor: widget.color,
            filled: widget.color != null,
            hintStyle: AppTextStyles.hintTextStyle,
            border: _border(AppColors.fieldBorderColor),
            enabledBorder: _border(AppColors.fieldBorderColor),
            focusedBorder: _border(AppColors.primaryColor),
            disabledBorder: _border(AppColors.fieldBorderColor),
            errorBorder: _border(AppColors.errorTextColor),
            focusedErrorBorder: _border(AppColors.errorTextColor),
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          icon: widget.isLoading
              ? Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : SizedBox(
                        height: 15.h,
                        width: 15.w,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
              : Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: !dropEnabled ? Colors.grey.shade400 : null,
                ),
        ),
      ),
    );
  }
}
