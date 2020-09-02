import 'package:flutter/material.dart';
import 'package:flights_app/ui/flight_dialog.dart';
import 'package:flights_app/ui/edit_flight_dialog.dart';
import 'package:flights_app/models/flight_list.dart';
import 'package:flights_app/util/db_helper.dart';
import 'package:intl/intl.dart';

void main() async {
  runApp(MyApp());
}

Map<int, Color> color =
{
  50:Color.fromRGBO(15,70,135, .1),
  100:Color.fromRGBO(15,70,135, .2),
  200:Color.fromRGBO(15,70,135, .3),
  300:Color.fromRGBO(15,70,135, .4),
  400:Color.fromRGBO(15,70,135, .5),
  500:Color.fromRGBO(15,70,135, .6),
  600:Color.fromRGBO(15,70,135, .7),
  700:Color.fromRGBO(15,70,135, .8),
  800:Color.fromRGBO(15,70,135, .9),
  900:Color.fromRGBO(15,70,135, 1),
};

class MyApp extends StatelessWidget {

  final MaterialColor colorDassu = MaterialColor(0xFF0D4789, color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dassu Flüge',
      theme: ThemeData(
        primarySwatch: colorDassu,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dassu Flüge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FlightList> flightList;
  int flightsToday;
  DbHelper helper = DbHelper();
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _bolderFont = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(flightList),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlightDialog()),
                );
              },
              child: Icon(Icons.add),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBody(List flightList) {
    if (flightList != null && flightList.length > 0)
      return _buildListView(flightList);
    else
      return _buildIntro();
  }

  Widget _buildIntro() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Hallo!',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Bei Schulungsflügen mit der Dassu kannst Du mit Hilfe dieser App Deine Startchecks machen, '
                  'Deine ungefähren Startzeitpunkte und die Anzahl der Flüge pro Tag festhalten.',
                style: _biggerFont,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Tippe auf das + Icon unten rechts um Deinen ersten Flug zu starten ...',
              style: _biggerFont,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List flightList) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 55,
          child: Text('Flüge heute: ' + flightsToday.toString(),
                       style: _bolderFont),
        ),
        Container(
          child: Divider(color: Colors.black54),
        ),
        Expanded(
          child: Container(
            child: _buildList(flightList),
          ),
        ),
      ]
    );
}

  Widget _buildList(List flightList) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.black26),
        itemCount: (flightList != null) ? flightList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              direction: DismissDirection.endToStart, // allow only one direction
              background: Container(
                color: Colors.red[800],
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(Icons.delete,
                    color: Colors.white),
              ),
              key: Key(flightList[index].id.toString()),
              child: ListTile(
                  title: Text(new DateFormat("dd.MM.yy      HH:mm").format(DateTime.fromMillisecondsSinceEpoch(flightList[index].datetime)),
                      style: _biggerFont),
                  subtitle: _showSubtitle(flightList[index].note),
                  trailing: Icon(
                    Icons.note_add,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditFlightDialog(flightList[index])),
                    );
                  }
              ),
              confirmDismiss: (direction) async {
                final bool res = await showDialog( context: context, builder: (BuildContext context) {
                  return AlertDialog(content: Text(
                      "Willst Du den Flug wirklich löschen?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Löschen",
                          style: TextStyle(color: Colors.red[800]),
                        ),
                        onPressed: () {
                          helper.deleteFlight(flightList[index]);
                          setState(() {
                            flightList.removeAt(index);
                          });
                          Navigator.of(context).pop(true);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Abbrechen",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                });
                return res;
              }

          );
        }
    );
  }

  Widget _showSubtitle(String note) {
    if (note == '')
      return null;

    return Text(
      note,
      style: new TextStyle(
        fontSize: 16.0,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    flightList = await helper.getFlights();
    flightsToday = await helper.getFlightsToday();
    setState(() {
      flightList = flightList;
      flightsToday = flightsToday;
    });
  }

}
