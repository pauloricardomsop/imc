import 'package:flutter/material.dart';

class StreamOut<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) child;
  final Function? preFunction;
  final bool condition;
  final Function? request;
  final Widget loading;

  const StreamOut({
    Key? key,
    required this.stream,
    required this.child,
    this.preFunction,
    this.condition = true,
    this.request,
    this.loading = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition && preFunction != null) preFunction!.call();
    return StreamBuilder<T>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
          if (snapshot.data != null) {
            return child(_, snapshot.requireData);
          } else {
            return loading;
          }
        } else {
          return loading;
        }
      },
    );
  }
}

class StreamOutNull<T> extends StatelessWidget {
  final Stream<T?> stream;
  final Widget Function(BuildContext context, T? data) child;
  final Function? preFunction;
  final bool condition;
  final Function? request;
  final Widget loading;

  const StreamOutNull({
    Key? key,
    required this.stream,
    required this.child,
    this.preFunction,
    this.condition = true,
    this.request,
    this.loading = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition && preFunction != null) preFunction!.call();
    return StreamBuilder<T?>(
      stream: stream,
      builder: (BuildContext _, AsyncSnapshot<T?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
          return child(_, snapshot.data);
        } else {
          return loading;
        }
      },
    );
  }
}
