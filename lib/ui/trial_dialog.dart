import 'package:flutter/material.dart';

class TrialDialog extends StatefulWidget {
  @override
  TrialDialogState createState() {
    return TrialDialogState();
  }
}

class TrialDialogState extends State<TrialDialog> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Trial Dialog"),
        ),
        body: Column(
          children: [
            Text('Hey'),
            Text('Ho'),
          ],
        ),
    );
  }


}
