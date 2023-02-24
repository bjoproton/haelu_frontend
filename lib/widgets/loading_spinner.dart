// External
import 'package:flutter/material.dart';

// Internal
import '../widgets/text.dart';

class LoadingSpinner extends StatelessWidget {
  final String text;
  
  LoadingSpinner({
      this.text = 'Loading...',
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 10),
        CircularProgressIndicator(),
      ]
    );
  }
}
