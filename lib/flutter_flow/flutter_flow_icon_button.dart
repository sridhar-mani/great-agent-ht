import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  const FlutterFlowIconButton({
    super.key,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.hoverColor,
    this.hoverIconColor,
    required this.icon,
    this.onPressed,
    this.showLoadingIndicator = false,
  });

  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? hoverColor;
  final Color? hoverIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = buttonSize ?? 40.0;
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: effectiveSize,
          height: effectiveSize,
          decoration: BoxDecoration(
            color: fillColor ?? Colors.transparent,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0.0,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
