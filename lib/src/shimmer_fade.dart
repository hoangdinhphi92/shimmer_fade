import 'package:flutter/material.dart';
import 'package:shimmer_fade/src/shimmer_fade_container.dart';

class ShimmerFade extends StatefulWidget {
  final Widget child;

  const ShimmerFade({super.key, required this.child});

  @override
  State<ShimmerFade> createState() => _ShimmerFadeState();
}

class _ShimmerFadeState extends State<ShimmerFade> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shimmerChanges?.removeListener(_onShimmerChange);

    _shimmerChanges = ShimmerFadeContainer.of(context).shimmerChanges;
    _shimmerChanges?.addListener(_onShimmerChange);
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final maskColor = ShimmerFadeContainer.of(context).maskColor;

    return Opacity(
      opacity: maskColor.opacity,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          maskColor.withOpacity(1),
          BlendMode.srcATop,
        ),
        child: widget.child,
      ),
    );
  }
}
