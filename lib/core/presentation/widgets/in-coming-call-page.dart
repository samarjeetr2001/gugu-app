import 'package:flutter/material.dart';

class InComingCallPage extends StatelessWidget {
  final Function acceptCallFunction;
  final Function declineCallFunction;
  const InComingCallPage(
      {Key? key,
      required this.acceptCallFunction,
      required this.declineCallFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => acceptCallFunction(),
                child: Text("Accept call")),
            TextButton(
                onPressed: () => declineCallFunction(),
                child: Text("Decline call")),
          ],
        )
      ],
    );
  }
}
