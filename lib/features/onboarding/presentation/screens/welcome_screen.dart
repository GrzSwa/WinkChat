import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winkchat/app/theme/app_colors.dart';
import 'package:winkchat/app/theme/app_dimensions.dart';
import 'package:winkchat/app/theme/app_typography.dart';

/// The welcome screen — first screen of the onboarding flow.
class WelcomeScreen extends StatelessWidget {
  /// Creates the welcome screen.
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.18),
                  radius: 1.2,
                  colors: [
                    AppColors.primaryDeep.withValues(alpha: 0.45),
                    AppColors.primaryDeep.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/winkchat-logo.svg',
                        height: 128,
                      ),
                      const SizedBox(
                        height: AppDimensions.xxl,
                      ),
                      const Text(
                        'WinkChat',
                        style: AppTypography.displayLarge,
                      ),
                      const SizedBox(
                        height: AppDimensions.sm,
                      ),
                      Text(
                        'Rozmawiaj anonimowo\nz ludźmi w pobliżu.',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Bez konta • Bez historii • Tylko teraz',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimensions.huge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
