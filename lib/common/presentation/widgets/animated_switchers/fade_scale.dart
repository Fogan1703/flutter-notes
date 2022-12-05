part of '../animated_switchers.dart';

class FadeScaleAnimatedSwitcher extends AnimatedSwitcher {
  FadeScaleAnimatedSwitcher({
    Key? key,
    required super.child,
  }) : super(
          key: key,
          duration: _kDuration,
          switchInCurve: _kSwitchInCurve,
          switchOutCurve: _kSwitchOutCurve,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
        );
}
