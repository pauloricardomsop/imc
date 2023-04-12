import 'package:flutter/material.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/h.dart';

class InFooterCta extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final bool invert;
  final Widget? subtitle;

  const InFooterCta(
      {required this.onTap,
      required this.icon,
      required this.label,
      this.invert = false,
      this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDDE0FF),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonIcon(
            onTap: onTap,
            icon: icon,
            label: label,
            invert: invert,
          ),
          if (subtitle != null) const H(8),
          if (subtitle != null) subtitle!
        ],
      ),
    );
  }
}

class InFooterCtaTemporary extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final bool invert;

  const InFooterCtaTemporary(
      {required this.onTap,
      required this.icon,
      required this.label,
      this.invert = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDDE0FF),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonIcon(
            onTap: onTap,
            icon: icon,
            label: label,
            invert: invert,
          ),
        ],
      ),
    );
  }
}
