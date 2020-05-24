class SongModel {
  int _id;
  String _title;
  String _author;
  int _imageId;
  int _backId;
  int _price;
  String _album;
  int _year;
  int _trackOrder;
  String _text;

  SongModel(this._id, this._title, this._author, this._imageId, this._backId,
      this._price, this._album, this._year, this._trackOrder, this._text);

  String get text => _text;

  int get trackOrder => _trackOrder;

  int get year => _year;

  String get album => _album;

  int get price => _price;

  int get backId => _backId;

  int get imageId => _imageId;

  String get author => _author;

  String get title => _title;

  int get id => _id;

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    json['id'],
    json['title'],
    json['_author'],
    json['_imageId'],
    json['_backId'],
    json['_price'],
    json['_album'],
    json['_year'],
    json['_trackOrder'],
    json['_text'],
  );
}
