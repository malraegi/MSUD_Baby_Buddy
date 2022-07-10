import 'dart:convert';

import 'package:epic/utils/constant.dart';

DeilyIntakeModel deilyIntakeModelFromJson(String str) => DeilyIntakeModel.fromJson(json.decode(str));

String deilyIntakeModelToJson(DeilyIntakeModel data) => json.encode(data.toJson());

class DeilyIntakeModel {
  DeilyIntakeModel({
    this.ile,
    this.leu,
    this.val,
    this.protein,
    this.energy,
    this.fluid,
    this.commercialMilk,
    this.medicinalMilk,
  });

  String ile;
  String leu;
  String val;
  String protein;
  String energy;
  String fluid;
  MilkType commercialMilk;
  MilkType medicinalMilk;

  factory DeilyIntakeModel.fromJson(Map<String, dynamic> json) => DeilyIntakeModel(
    ile: json["ILE"],
    leu: json["LEU"],
    val: json["VAL"],
    protein: json["protein"],
    energy: json["energy"],
    fluid: json["fluid"],
    commercialMilk: json["commercial-milk"] == -1 ? null : MilkType.values[json["commercial-milk"]],
    medicinalMilk: json["medicinal-milk"] == -1 ? null : MilkType.values[json["medicinal-milk"]],
  );

  Map<String, dynamic> toJson() => {
    "ILE": ile,
    "LEU": leu,
    "VAL": val,
    "protein": protein,
    "energy": energy,
    "fluid": fluid,
    "commercial-milk": commercialMilk == null ? -1 : commercialMilk.index,
    "medicinal-milk": medicinalMilk == null ? -1 : medicinalMilk.index,
  };
}
