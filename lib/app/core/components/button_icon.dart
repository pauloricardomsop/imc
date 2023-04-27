import 'package:flutter/material.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class ButtonIcon extends StatelessWidget {
  final void Function() onTap;
  final IconData? icon;
  final Widget? widget;
  final String label;
  final bool invert;
  final Color? textColor;
  final Color? backgroundColor;

  const ButtonIcon(
      {required this.onTap,
      this.icon,
      required this.label,
      this.invert = false,
      this.widget,
      this.textColor,
      this.backgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF1C44F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: hasIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    invert ? text : iconWidget,
                    const W(12),
                    invert ? iconWidget : text,
                  ],
                )
              : text,
        ),
      ),
    );
  }

  Widget get iconWidget =>
      widget ??
      Icon(
        icon ?? Icons.open_in_new,
        size: 28,
        color: textColor ?? const Color(0xFFFFFFFF),
      );

  bool get hasIcon => widget != null || icon != null;

  Widget get text => Container(
        margin: const EdgeInsets.only(bottom: 6),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTheme.text.semi.lg(textColor ?? const Color(0xFFFFFFFF)),
        ),
      );
}

class ButtonIconSmall extends StatelessWidget {
  final void Function() onTap;
  final dynamic icon;
  final String label;
  final bool invert;

  const ButtonIconSmall(
      {required this.onTap,
      required this.icon,
      required this.label,
      this.invert = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF1C44F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const W(4),
            invert ? text : iconWidget,
            const W(6),
            invert ? iconWidget : text,
            const W(4),
          ],
        ),
      ),
    );
  }

  Widget get iconWidget => icon is Widget
      ? icon
      : Icon(
          icon,
          size: 16,
          color: const Color(0xFFFFFFFF),
        );

  Widget get text => Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Text(
          label,
          style: AppTheme.text.semi.lg(const Color(0xFFFFFFFF)).copyWith(fontSize: 14),
        ),
      );
}
