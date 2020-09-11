import 'package:intl/intl.dart';

class Flight {
  int id;
  String note;
  int datetime;
  String status;
  //String status;

  Flight (this.id, this.note, this.datetime, this.status);

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0)?null:id,
      'note': note,
      'datetime': datetime,
      'status': status,
    };
  }

  String displayDate() {
    return new DateFormat("dd.MM.yy      HH:mm").format(DateTime.fromMillisecondsSinceEpoch(this.datetime)).toString();
  }


}

