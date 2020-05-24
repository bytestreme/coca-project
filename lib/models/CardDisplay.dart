import 'package:cocaapp/models/RarityModel.dart';

class CardDisplay {
  int id;
  String title;
  String description;
  int requiredNumber;
  RarityModel rarity;
  int imageId;
  int quantity;

  CardDisplay.name(this.id, this.title, this.description, this.requiredNumber,
      this.rarity, this.imageId, this.quantity);
}