import 'dart:ui';

import 'package:flutter/material.dart';

class ShimmerFadeContainer extends StatefulWidget {
  static ShimmerFadeContainerState of(BuildContext context) {
    final state = context.findAncestorStateOfType<ShimmerFadeContainerState>();
    if (state == null) {
      throw UnimplementedError(
        "Please use ShimmerFadeContainer parent of ShimmerFade",
      );
    }

    return state;
  }

  final Color fromColor;
  final Color toColor;
  final Duration duration;
  final Widget child;

  const ShimmerFadeContainer({
    super.key,
    this.fromColor = const Color(0x11F4F4F4),
    this.toColor = const Color(0x33F4F4F4),
    this.duration = const Duration(seconds: 3),
    required this.child,
  });

  @override
  State<ShimmerFadeContainer> createState() => ShimmerFadeContainerState();
}

class ShimmerFadeContainerState extends State<ShimmerFadeContainer>
    with SingleTickerProviderStateMixin {
  double get progress => _shimmerController.value;
  
  Color get maskColor => Color.lerp(widget.fromColor, widget.toColor, progress)!;

  Listenable get shimmerChanges => _shimmerChanges;

  late _ShimmerListenable _shimmerChanges;

  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerChanges = _ShimmerListenable(
      onListenableChanged: _onListenableChanged,
    );

    _shimmerController = AnimationController.unbounded(vsync: this);
    _shimmerController.addListener(_onShimmerChanged);
  }

  void _repeat() {
    _shimmerController.repeat(
      min: 0,
      max: 1,
      reverse: true,
      period: const Duration(milliseconds: 1000),
    );
  }

  void _onListenableChanged(bool hasListeners) {
    if (hasListeners) {
      _repeat();
    } else {
      _shimmerController.stop();
    }
  }

  void _onShimmerChanged() {
    _shimmerChanges.invalidate();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _ShimmerListenable extends ChangeNotifier {
  final ValueChanged<bool> onListenableChanged;

  bool _isHasListeners = false;

  set isHasListeners(bool value) {
    if (_isHasListeners != value) {
      _isHasListeners = value;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => onListenableChanged(value),
      );
    }
  }

  _ShimmerListenable({required this.onListenableChanged});

  void invalidate() => notifyListeners();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    isHasListeners = hasListeners;
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);

    isHasListeners = hasListeners;
  }
}
