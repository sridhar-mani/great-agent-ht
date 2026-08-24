import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'button_model.dart';
export 'button_model.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.icon,
    this.iconPresent = false,
    this.iconEndPresent = false,
    this.content = 'Button',
    this.variant = 'primary',
    this.size = 'medium',
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.onTap,
  });

  final Widget? icon;
  final bool iconPresent;
  final bool iconEndPresent;
  final String content;
  final String variant; // 'primary', 'secondary', 'outline', 'ghost'
  final String size; // 'small', 'medium', 'large'
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final VoidCallback? onTap;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late ButtonModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (widget.variant) {
      case 'outline':
        bgColor = Colors.transparent;
        textColor = FlutterFlowTheme.of(context).primaryText;
        border = Border.all(color: FlutterFlowTheme.of(context).alternate, width: 1.5);
        break;
      case 'secondary':
        bgColor = FlutterFlowTheme.of(context).primary5;
        textColor = FlutterFlowTheme.of(context).primary;
        border = Border.all(color: FlutterFlowTheme.of(context).primary20, width: 1);
        break;
      case 'ghost':
        bgColor = Colors.transparent;
        textColor = FlutterFlowTheme.of(context).secondaryText;
        border = null;
        break;
      case 'primary':
      default:
        bgColor = FlutterFlowTheme.of(context).primary;
        textColor = Colors.white;
        border = null;
        break;
    }

    double height = 44.0;
    double fontSize = 14.0;
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

    if (widget.size == 'large') {
      height = 52.0;
      fontSize = 15.0;
      padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0);
    } else if (widget.size == 'small') {
      height = 36.0;
      fontSize = 12.0;
      padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    }

    Widget contentChild = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.iconPresent && widget.icon != null) ...[
          widget.icon!,
          const SizedBox(width: 8),
        ],
        Text(
          widget.content,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (widget.iconEndPresent && widget.icon != null) ...[
          const SizedBox(width: 8),
          widget.icon!,
        ],
      ],
    );

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1.0,
      child: Container(
        width: widget.fullWidth ? double.infinity : null,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow: widget.variant == 'primary'
              ? [
                  BoxShadow(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.disabled ? null : widget.onTap,
            child: Padding(
              padding: padding,
              child: Center(
                child: widget.loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                      )
                    : contentChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
