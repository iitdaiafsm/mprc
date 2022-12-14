import 'package:flutter/material.dart';

class MyStreamBuilder<T> extends StatelessWidget {
  final Widget Function(T) builder;
  final Stream<T> stream;

  const MyStreamBuilder({Key? key, required this.stream, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor)),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const SizedBox(
                width: 20,
                height: 20,
                child: FittedBox(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  )),
                ),
              );
            case ConnectionState.waiting:
              return const SizedBox(
                width: 20,
                height: 20,
                child: FittedBox(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.yellow,
                  )),
                ),
              );
            case ConnectionState.active:
              return builder(snapshot.requireData);
            case ConnectionState.done:
              return builder(snapshot.requireData);
          }
        }
      },
    );
  }
}
