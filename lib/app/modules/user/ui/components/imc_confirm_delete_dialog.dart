import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';

class ImcConfirmDialog extends StatelessWidget {
  const ImcConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'delete_confirmation'.tr(),
                style: const TextStyle(
                    color: Color(0xFF000000), fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const H(8),
              Text(
                'confirm_delete_record'.tr(),
                style: const TextStyle(color: Color(0xFF000000)),
              ),
              const H(24),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'cancel'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF3559cf)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'delete'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF3559cf)),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
