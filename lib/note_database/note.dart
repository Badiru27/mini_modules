
class PersonalNote{

  //Parameters
  int _id;
  String _title;
  String _description;
  String _date;

  // Constructors
  PersonalNote( this._title, this._description, this._date);
  PersonalNote.withId(this._id, this._title, this._description, this._date);

  //Defining Getters

int get id => _id;
String get title => _title;
String get description => _description;
String get date => _date;

// Defining the Setters

  set title(String newTitle){
    if(newTitle.length <= 255){
      this._title = newTitle;
    }
  }

  set description(String newDescription){
    if(newDescription.length <= 255){
      this._description = newDescription;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //Converting Note Object into Map Object

 Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if (id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
}

//Converting Map object into Note Object
 PersonalNote.fromMapObject(Map<String, dynamic> map){

    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
 }
}