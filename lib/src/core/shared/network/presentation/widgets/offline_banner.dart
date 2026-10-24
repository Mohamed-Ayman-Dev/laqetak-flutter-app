import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../themes/text_styles.dart';
import '../cubit/network_cubit.dart';
import '../cubit/network_state.dart';

/// A non-intrusive top banner that informs the user about network connectivity
/// changes with smooth animations.
class OfflineBanner extends StatelessWidget {
  final Widget child;

  const OfflineBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        final isVisible = state.isDisconnected || state.justRestored;
        final isRestored = state.justRestored;
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';

        final backgroundColor =
            isRestored ? AppColors.successDarkColor : AppColors.errorColor;

        final icon =
            isRestored ? Icons.wifi_rounded : Icons.wifi_off_rounded;

        final message = isRestored
            ? (isArabic
                ? 'تمت استعادة الاتصال بالإنترنت'
                : 'Internet connection restored')
            : S.of(context).noInternetConnection;

        return Stack(
          children: [
            child,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: true,
                bottom: false,
                child: IgnorePointer(
                  ignoring: !isVisible,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    offset: isVisible ? Offset.zero : const Offset(0, -1.2),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: isVisible ? 1.0 : 0.0,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  message,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
