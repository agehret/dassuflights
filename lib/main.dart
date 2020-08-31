import 'package:flutter/material.dart';
import 'package:flights_app/ui/flight_dialog.dart';
import 'package:flights_app/ui/edit_flight_dialog.dart';
import 'package:flights_app/models/flight_list.dart';
import 'package:flights_app/util/db_helper.dart';
import 'package:intl/intl.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flight App'),
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
      body: _buildListView(flightList),
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


  Widget _buildListView(List flightList) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 55,
          child: Text('Flüge heute: ' + flightsToday.toString(),
                       style: _bolderFont),//_buildList(flightList),
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
        separatorBuilder: (context, index) => Divider(),
        itemCount: (flightList != null) ? flightList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete,
                    color: Colors.white),
              ),
              key: Key(flightList[index].id.toString()), // Key(index.toString() + '_' + flightList[index].datetime.toString()),
              child: ListTile(
                  title: Text(new DateFormat("dd.MM.yy HH:mm").format(DateTime.fromMillisecondsSinceEpoch(flightList[index].datetime)),
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
              confirmDismiss: (direction) {
                helper.deleteFlight(flightList[index]);
                setState(() {
                  flightList.removeAt(index);
                });
                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("Flug wurde gelöscht."))
                );
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
