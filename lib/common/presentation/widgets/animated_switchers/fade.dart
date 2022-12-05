part of '../animated_switchers.dart';

class FadeAnimatedSwitcher extends AnimatedSwitcher {
  FadeAnimatedSwitcher({
    Key? key,
    required super.child,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          duration: _kDuration,
          switchInCurve: _kSwitchInCurve,
          switchOutCurve: _kSwitchOutCurve,
          layoutBuilder: (currentChild, previousChildren) => Stack(
            alignment: alignment,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
        );
}
