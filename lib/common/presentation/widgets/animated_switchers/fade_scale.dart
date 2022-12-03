part of '../animated_switchers.dart';

class FadeScaleAnimatedSwitcher extends StatelessWidget {
  const FadeScaleAnimatedSwitcher({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
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
      child: child,
    );
  }
}
