# Shimmer Fade

The `shimmer_fade` package provides an easy way to add a shimmer effect similar to what you see on Facebook or Netflix. It's super fast, lightweight, and easy to set up.

<img src="https://github.com/hnvn/flutter_shimmer/blob/master/screenshots/loading_list.gif?raw=true"/>

## How to Use

First, import the package into your Dart file:

```dart
import 'package:shimmer_fade/shimmer_fade.dart';
```

### 1. Setting Up the Shimmer Fade Container

The `ShimmerFadeContainer` is required to synchronize the animation across all child shimmer elements. Here's how to set it up:

```dart
ShimmerFadeContainer(
  fromColor: const Color(0x11F4F4F4),
  toColor: const Color(0x33F4F4F4),
  duration: const Duration(seconds: 3),
  child: ListView(
    physics: const NeverScrollableScrollPhysics(),
    children: [
      const SizedBox(height: 16),
      _buildTopRowList(),
      const SizedBox(height: 16),
      _buildListItem(),
      _buildListItem(),
      _buildListItem(),
    ],
  ),
)
```

### 2. Applying the Shimmer Effect

Inside the `ShimmerFadeContainer`, you can apply the shimmer effect to any shape by wrapping your loading widget inside a `ShimmerFade` widget. This will preserve the shape of the child while applying the shimmer effect. The shimmer animation's color will be consistent with the `ShimmerFadeContainer`.

```dart
ShimmerFade(
  child: CardListItem(),
)
```

---

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:shimmer_fade/shimmer_fade.dart';

class MyShimmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShimmerFadeContainer(
        fromColor: const Color(0x11F4F4F4),
        toColor: const Color(0x33F4F4F4),
        duration: const Duration(seconds: 3),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 16),
            _buildTopRowList(),
            const SizedBox(height: 16),
            ShimmerFade(
              child: _buildListItem(),
            ),
            ShimmerFade(
              child: _buildListItem(),
            ),
            ShimmerFade(
              child: _buildListItem(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRowList() {
    // Your widget code here
  }

  Widget _buildListItem() {
    // Your widget code here
  }
}
```

This setup will provide a smooth, shimmering effect across your app, giving it a polished and modern look.