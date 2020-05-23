import 'package:cocaapp/models/RarityModel.dart';

class CardModel {
  int _id;
  String _title;
  String _description;
  int _requiredNumber;
  RarityModel _rarity;
  int _imageId;

  CardModel(this._id, this._title, this._description, this._requiredNumber,
      this._rarity, this._imageId);

  int get imageId => _imageId;

  RarityModel get rarity => _rarity;

  int get requiredNumber => _requiredNumber;

  String get description => _description;

  String get title => _title;

  int get id => _id;
}
