import 'package:flutter/material.dart';
import 'package:flights_app/ui/ui_styles.dart';

class AboutAppDialog extends StatefulWidget {
  @override
  AboutAppDialogState createState() {
    return AboutAppDialogState();
  }
}

class AboutAppDialogState extends State<AboutAppDialog> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Über die App"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment(0.0, 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Text('Hey!',
                                 style: heading1
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('Diese kleine App kann Dir bei Deiner Ausbildung '
                      ' bei der Deutschen Alpensegeflugschule (Dassu) helfen, sie erfüllt zwei Aufgaben:',
                      style: biggerFont),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text('1. Du kannst Deinen StartCheck auf Deinem Handy machen und brauchst die kleine StartCheck-Karte nicht mehr.',
                      style: biggerFont),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text('2. Du kannst den ungefähren Startzeitpunkt Deiner Flüge, die Anzahl der Flüge pro Tag und Notizen zu den Flügen speichern.',
                      style: biggerFont),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                  child: Text('Was diese App nicht macht: Du kannst Deine Flüge nicht auf einer Karte tracken, '
                              ' Du kannst nicht den genauen Start- und Landezeitpunkt festhalten.\nDas liegt einfach daran, '
                              'dass die Eintragungen des Flugleiters in der Datenbank die führenden Daten sind '
                              '(auf die wir gerade keinen Zugriff haben) und jeder Versuch das irgendwie zu duplizieren '
                              'vermutlich in inkonsistenten Daten enden wird.\n\nDiese App ist in keiner Weise'
                              ' mit Deutsche Alpensegelflugschule Unterwössen e.V. verbunden, sie ist ein privates '
                              'Open-Source Projekt, für Fehler und daraus resultierende Folgen wird keine Haftung übernommen.'
                              '\n\n'
                              'Die Nutzung der App entbindet Dich nicht von der handschriftlichen Führung eines Flugbuches.',
                      ),
                ),
              ],

            )
        )
    );
  }

}
