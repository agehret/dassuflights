import 'package:flutter/material.dart';
import 'package:flights_app/models/flight.dart';
import 'package:flights_app/util/db_helper.dart';

class FlightDialog extends StatefulWidget {
  @override
  FlightDialogState createState() {
    return FlightDialogState();
  }
}

class FlightDialogState extends State<FlightDialog> {
  final _saved = Set<String>();
  List<String> checkitems = <String> [
    "Kuller ab",
    "-",
    "Beladung im zulässigen Bereich, Ballast sicher befestigt",
    "-",
    "Fallschirm richtig angelegt, Auslösegriff bekannt",
    "-",
    "Richtig und fest angeschnallt",
    "-",
    "Bremsklappen geprüft, eingefahren und verriegelt",
    "-",
    "Höhenmesser eingestellt",
    "-",
    "Funkgerät eingeschaltet, Frequenz geprüft, hohe Lautstärke",
    "-",
    "Trimmung eingestellt",
    "-",
    "Alle Ruder freigängig",
    "-",
    "Prüfung der Windverhältnisse",
    "-",
    "Verfahren bei Startunterbrechung",
    "-",
    "Haube zu und verriegelt, Notabwurfvorrichtung bekannt",
    "-",
    "Helfer benutzt richtige Sollbruchstelle",
    "-",
    "Startstrecke und Ausklinkraum frei",
    "-",
    "Startbereitschaft durch eindeutiges Handzeichen anzeigen",
    "-",
    "button",
  ];
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Neuer Flug"),
        ),
      body:
      Column(
          children: <Widget>[
            Expanded(
              child: _buildSuggestions()
            )
      ])
    );
  }

  Widget _buildSuggestions() {
    DbHelper helper = DbHelper();
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: checkitems.length,
        itemBuilder: /*1*/ (context, i) {
          if (checkitems[i] == '-')
            return Divider();
          if (checkitems[i] == 'button')
            return MaterialButton(
              child: Text("Flug starten", style: _biggerFont),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              padding: EdgeInsets.all(16.0),
              onPressed: () {
                Flight flight = Flight(0,'',0, 'init');
                flight.datetime = DateTime.now().millisecondsSinceEpoch;
                helper.insertFlight(flight);
                Navigator.pop(context);
              },
            );
          return _buildRow(checkitems[i]);
        });
  }

  Widget _buildRow(checkitem) {
    final alreadySaved = _saved.contains(checkitem);
    return ListTile(
      title: Text(
        checkitem,
        style: _biggerFont,
      ),
      leading: Icon(
      alreadySaved ? Icons.check_circle : null,
      color: alreadySaved ? Colors.green : null,
    ),
      onTap: () {
        setState(() {
            _saved.add(checkitem);
        });
      },
    );
  }
}
