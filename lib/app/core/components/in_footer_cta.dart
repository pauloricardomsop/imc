import 'package:benefits_brazil/app/core/components/button_icon.dart';
import 'package:flutter/material.dart';

class InFooterCta extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final bool invert;

  const InFooterCta(
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
      child: ButtonIcon(
        onTap: onTap,
        icon: icon,
        label: label,
        invert: invert,
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
      child: ButtonIcon(
        onTap: onTap,
        icon: icon,
        label: label,
        invert: invert,
      ),
    );
  }
}
