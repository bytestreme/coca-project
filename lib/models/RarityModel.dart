class RarityModel {
  int _id;
  String _title;
  int _outOfAll;
  String _hexColor;

  RarityModel(this._id, this._title, this._outOfAll, this._hexColor);

  String get hexColor => _hexColor;

  int get outOfAll => _outOfAll;

  String get title => _title;

  int get id => _id;
}
