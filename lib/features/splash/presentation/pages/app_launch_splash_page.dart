import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:safirah/core/theme/app_colors.dart';

class AppLaunchSplashPage extends StatefulWidget {
  const AppLaunchSplashPage({
    super.key,
    required this.child,
    this.animationBuilder,
  });

  final Widget child;
  final Widget Function(VoidCallback onAnimationFinished)? animationBuilder;

  @override
  State<AppLaunchSplashPage> createState() => _AppLaunchSplashPageState();
}

class _AppLaunchSplashPageState extends State<AppLaunchSplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _showSplash = true;
  bool _didFinishAnimation = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _finishSplash();
        }
      });
  }

  void _finishSplash() {
    if (_didFinishAnimation || !mounted) return;
    _didFinishAnimation = true;
    setState(() {
      _showSplash = false;
    });
  }

  void _handleCompositionLoaded(LottieComposition composition) {
    if (_didFinishAnimation) return;

    _animationController
      ..duration = composition.duration
      ..forward(from: 0);
  }

  Widget _buildAnimation() {
    final customBuilder = widget.animationBuilder;
    if (customBuilder != null) {
      return customBuilder(_finishSplash);
    }

    return Lottie.asset(
      'assets/safirah.json',
      controller: _animationController,
      repeat: false,
      fit: BoxFit.contain,
      onLoaded: _handleCompositionLoaded,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: _showSplash
          ? _SplashScaffold(
              key: const ValueKey('launch-splash'),
              animationWidget: _buildAnimation(),
            )
          : KeyedSubtree(
              key: const ValueKey('launch-home'),
              child: widget.child,
            ),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
    );
  }
}

class _SplashScaffold extends StatelessWidget {
  const _SplashScaffold({super.key, this.animationWidget});

  final Widget? animationWidget;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.secondaryColor,
        systemNavigationBarDividerColor: AppColors.secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final animationSize = constraints.biggest.shortestSide;

            return Center(
              child: SizedBox.square(
                dimension: animationSize,
                child: RepaintBoundary(
                  child: widgetAnimation,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget get widgetAnimation {
    return animationWidget ??
        Lottie.asset(
          'assets/safirah.json',
          repeat: false,
          fit: BoxFit.contain,
        );
  }
}





