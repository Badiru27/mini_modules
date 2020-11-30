
class ExamDatabase{

  // Defining Class Parameters
  int _id;
  String _courseTitle;
  String _courseCode;
  String _venue;
  String _date;
  String _fromTime;
  String _toTime;

  ExamDatabase(this._courseCode, this._venue, this._date, this._fromTime, this._toTime, [this._courseTitle]);
  ExamDatabase.withID(this._id, this._courseCode, this._venue, this._date, this._fromTime, this._toTime, [this._courseTitle]);

//Defining Getter for constructor
  int get id => _id;
  String get courseTitle => _courseTitle;
  String get courseCode => _courseCode;
  String get venue => _venue;
  String get date => _date;
  String get fromTime => _fromTime;
  String get toTime => _toTime;


//Defining Setter for Constructor

 set courseTitle( String newCourseTitle){
   if(newCourseTitle.length <= 100){
     this._courseTitle = newCourseTitle;
   }
 }

  set courseCode(String newCourseCode){
   if(newCourseCode.length <= 15){
     this._courseCode = newCourseCode;
   }
 }

  set venue(String newVenue){
   if(newVenue.length <= 255){
     this._venue = newVenue;
   }
  }

  set date(String newDate){
   this._date = newDate;
  }

  set fromTime(String newFromTime){
   this._fromTime = newFromTime;
  }

  set toTime(String newToTime){
   this._toTime = newToTime;
  }

  //Converting Object into Map Object
  Map<String, dynamic> toMap(){

   var map = Map<String, dynamic>();

   if( id != null){
     map['id'] = _id;
   }

   map['courseTitle'] = _courseTitle;
   map['courseCode'] = _courseCode;
   map['venue'] = _venue;
   map['date'] = _date;
   map['fromTime'] = _fromTime;
   map['toTime'] = _toTime;

   return map;
  }

  //Converting map object to object

 ExamDatabase.fromMapObject(Map<String, dynamic> map){

   this._id = map['id'];
   this._courseTitle = map['courseTitle'];
   this._courseCode = map['courseCode'];
   this._venue = map['venue'];
   this._date = map['date'];
   this._fromTime = map['fromTime'];
   this._toTime = map['toTime'];
 }

}