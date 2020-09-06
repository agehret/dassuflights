import 'package:flights_app/models/flight.dart';
import 'package:flutter/material.dart';
import 'package:flights_app/util/db_helper.dart';

class EditFlightDialog extends StatefulWidget {
  final Flight flightList;
  EditFlightDialog(this.flightList);
  @override
  EditFlightDialogState createState() {
    return EditFlightDialogState();
  }
}

class EditFlightDialogState extends State<EditFlightDialog> {
  final _formKey = GlobalKey();
  final _biggerFont = TextStyle(fontSize: 18.0);
  DbHelper helper = DbHelper();

  TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    _noteController = new TextEditingController(text: widget.flightList.note);
  }

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Notiz bearbeiten"),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _noteController,
                            decoration:
                                InputDecoration(labelText: 'Notiz'),
                            maxLines: 8,
                            autofocus: true,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: MaterialButton(
                              child: Text("Speichern", style: _biggerFont),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16.0),
                              onPressed: () {
                                widget.flightList.note = _noteController.text;
                                helper.updateFlight(widget.flightList);
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}
