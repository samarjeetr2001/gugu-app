import 'package:flutter/material.dart';

class OutGoingCallPage extends StatelessWidget {
  final Function endCallFunction;
  const OutGoingCallPage({Key? key, required this.endCallFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => endCallFunction(),
          child: Text(" End call"),
        ),
      ],
    );
  }
}
