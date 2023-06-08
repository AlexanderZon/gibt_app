import 'package:gibt_1/models/models.dart';

class FarmingMaterialData {
  final MaterialItem material;
  List<FarmingMaterialItemData> items;
  int quantity;

  FarmingMaterialData(
      {required this.material, required this.quantity, required this.items});
}

class FarmingMaterialItemData {
  final AccountCharacter accountCharacter;
  int quantity;
  final String type;

  FarmingMaterialItemData({
    required this.accountCharacter,
    required this.quantity,
    required this.type,
  });
}
