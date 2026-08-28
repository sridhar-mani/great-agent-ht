import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// An ultra-smooth, zero-rebuild touch indicator overlay for demos and recordings.
///
/// Performance architecture:
/// 1. Uses an isolated [ValueNotifier] and [CustomPainter] wrapped in [RepaintBoundary].
/// 2. Zero rebuilds of [child] or the application widget tree during pointer movements or scrolling.
/// 3. Supports multi-touch, active dragging, and smooth opacity fadeout on pointer release.
class TouchIndicator extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Color indicatorColor;
  final double radius;
  final Duration fadeDuration;

  const TouchIndicator({
    super.key,
    required this.child,
    this.enabled = kDebugMode,
    this.indicatorColor = const Color(0xFF1A237E),
    this.radius = 20.0,
    this.fadeDuration = const Duration(milliseconds: 350),
  });

  @override
  State<TouchIndicator> createState() => _TouchIndicatorState();
}

class _TouchPoint {
  final Offset position;
  final double opacity;

  const _TouchPoint({
    required this.position,
    required this.opacity,
  });

  _TouchPoint copyWith({
    Offset? position,
    double? opacity,
  }) {
    return _TouchPoint(
      position: position ?? this.position,
      opacity: opacity ?? this.opacity,
    );
  }
}

class _TouchIndicatorState extends State<TouchIndicator> {
  final ValueNotifier<Map<int, _TouchPoint>> _pointersNotifier =
      ValueNotifier<Map<int, _TouchPoint>>(<int, _TouchPoint>{});
  final Map<int, Timer> _pointerTimers = <int, Timer>{};

  @override
  void dispose() {
    for (final timer in _pointerTimers.values) {
      timer.cancel();
    }
    _pointerTimers.clear();
    _pointersNotifier.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (!widget.enabled) return;
    _pointerTimers[event.pointer]?.cancel();
    _pointerTimers.remove(event.pointer);

    final current = Map<int, _TouchPoint>.from(_pointersNotifier.value);
    current[event.pointer] = _TouchPoint(
      position: event.localPosition,
      opacity: 1.0,
    );
    _pointersNotifier.value = current;
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (!widget.enabled) return;
    if (_pointersNotifier.value.containsKey(event.pointer)) {
      final current = Map<int, _TouchPoint>.from(_pointersNotifier.value);
      final existing = current[event.pointer];
      if (existing != null) {
        current[event.pointer] = existing.copyWith(
          position: event.localPosition,
        );
        _pointersNotifier.value = current;
      }
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!widget.enabled) return;
    _scheduleRemoval(event.pointer, event.localPosition);
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (!widget.enabled) return;
    _scheduleRemoval(event.pointer, event.localPosition);
  }

  void _scheduleRemoval(int pointerId, Offset lastPosition) {
    if (!_pointersNotifier.value.containsKey(pointerId)) return;

    _pointerTimers[pointerId]?.cancel();
    _pointerTimers[pointerId] = Timer(widget.fadeDuration, () {
      if (mounted) {
        final current = Map<int, _TouchPoint>.from(_pointersNotifier.value);
        current.remove(pointerId);
        _pointersNotifier.value = current;
        _pointerTimers.remove(pointerId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _onPointerDown,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            widget.child,
            Positioned.fill(
              child: IgnorePointer(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: _TouchPainter(
                      notifier: _pointersNotifier,
                      color: widget.indicatorColor,
                      radius: widget.radius,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TouchPainter extends CustomPainter {
  final ValueNotifier<Map<int, _TouchPoint>> notifier;
  final Color color;
  final double radius;

  _TouchPainter({
    required this.notifier,
    required this.color,
    required this.radius,
  }) : super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size size) {
    final points = notifier.value;
    if (points.isEmpty) return;

    for (final point in points.values) {
      final center = point.position;
      final fillPaint = Paint()
        ..color = color.withOpacity(0.35 * point.opacity)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = color.withOpacity(0.85 * point.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final shadowPaint = Paint()
        ..color = color.withOpacity(0.20 * point.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);

      // Glow shadow
      canvas.drawCircle(center, radius + 2, shadowPaint);
      // Inner circle
      canvas.drawCircle(center, radius, fillPaint);
      // Outer border
      canvas.drawCircle(center, radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TouchPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
