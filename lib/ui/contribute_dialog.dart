import 'package:flutter/material.dart';
import 'package:flights_app/ui/ui_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributeDialog extends StatefulWidget {
  @override
  ContributeDialogState createState() {
    return ContributeDialogState();
  }
}

class ContributeDialogState extends State<ContributeDialog> {
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
                    child: Text('Beitragen',
                        style: heading1
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('Du wünscht Dir weitere Funktionen oder hast einen Fehler entdeckt?\n\nDu kannst ganz einfach'
                              ' dazu beitragen diese App zu verbessern in dem Du ein Ticket erstellst:',
                      style: biggerFont),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16.0),
                        onPressed: _launchTicketURL,
                        child: Text('Neues Ticket erstellen'),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: Text('Oder den Flutter-Code selbst erweiterst und einen Pull-Request erstellst:',
                      style: biggerFont),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        onPressed: _launchCodeURL,
                        child: Text('Code ansehen'),
                      )
                  ),
                ),
              ],

            )
        )
    );
  }

}

_launchTicketURL() async {
  const url = 'https://github.com/agehret/dassuflights/issues/new';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchCodeURL() async {
  const url = 'https://github.com/agehret/dassuflights';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

