class FlightList {
  int id;
  String note;
  int datetime;

  FlightList (this.id, this.note, this.datetime);

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0)?null:id,
      'note': note,
      'datetime': datetime,
    };
  }


}

