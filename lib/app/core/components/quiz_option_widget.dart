import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';

class QuizOptionModel {
  final String label;
  QuizOptionModel(this.label);
}

class QuizOptionWidget extends StatelessWidget {
  final List<QuizOptionModel> options;
  final QuizOptionModel? option;
  final Function(QuizOptionModel) onChanged;

  const QuizOptionWidget(
      {required this.options, required this.option, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (_, i) => const H(8),
      itemBuilder: (_, i) => _itemWidget(options[i]),
    );
  }

  InkWell _itemWidget(QuizOptionModel e) {
    bool selected = option == e;
    return InkWell(
      onTap: () => onChanged.call(e),
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: selected ? const Color(0xFF1C44F9) : const Color(0xFFFFFFFF),
              border:
                  Border.all(color: selected ? const Color(0xFF1C44F9) : const Color(0xFF777777))),
          width: double.maxFinite,
          child: Row(
            children: [
              Radio<QuizOptionModel>(
                value: e,
                groupValue: option,
                onChanged: (e) {},
                fillColor: MaterialStateProperty.all(
                    selected ? const Color(0xFFFFFFFF) : const Color(0xFF777777)),
              ),
              Expanded(
                child: Text(e.label,
                    style: TextStyle(
                      color: selected ? const Color(0xFFFFFFFF) : const Color(0xFF777777),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
