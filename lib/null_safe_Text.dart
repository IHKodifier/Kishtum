import 'package:flutter/material.dart';

class NullSafeText extends StatelessWidget {
  final String data;
  final TextStyle style;

  const NullSafeText({Key key, @required this.data, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Text(data);
    } else {
      return Text(
        'info not available',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 8, fontStyle: FontStyle.italic, color: Colors.red),
      );
    }
  }
}
