import 'package:intl/intl.dart';

class Flight {
  int id;
  String note;
  int datetime;

  Flight (this.id, this.note, this.datetime);

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0)?null:id,
      'note': note,
      'datetime': datetime,
    };
  }

  String displayDate() {
    return new DateFormat("dd.MM.yy      HH:mm").format(DateTime.fromMillisecondsSinceEpoch(this.datetime)).toString();
  }


}

