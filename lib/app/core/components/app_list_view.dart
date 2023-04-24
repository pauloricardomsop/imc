import 'package:flutter/cupertino.dart';

class AppListView extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const AppListView({required this.children, this.padding, super.key});

  @override
  State<AppListView> createState() => _AppListViewState();
}

class _AppListViewState extends State<AppListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      children: widget.children,
    );
  }
}
