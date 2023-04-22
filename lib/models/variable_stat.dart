

import 'package:gibt_1/models/models.dart';

enum VariableStat {
  CRIT_DMG,
  HEAL,
  EM,
  HP,
  ER,
  CRIT_RATE,
  PHYS,
  ATK,
  ELEC,
  GEO,
  PYRO,
  HYDRO,
  DEF,
  CRYO,
  ANEMO,
  DENDRO
}

final variableStatValues = EnumValues({
  "Anemo%": VariableStat.ANEMO,
  "Atk%": VariableStat.ATK,
  "CritDMG%": VariableStat.CRIT_DMG,
  "CritRate%": VariableStat.CRIT_RATE,
  "Cryo%": VariableStat.CRYO,
  "Def": VariableStat.DEF,
  "Dendro%": VariableStat.DENDRO,
  "Elec%": VariableStat.ELEC,
  "EM": VariableStat.EM,
  "ER": VariableStat.ER,
  "Geo%": VariableStat.GEO,
  "Heal": VariableStat.HEAL,
  "HP%": VariableStat.HP,
  "Hydro%": VariableStat.HYDRO,
  "Phys%": VariableStat.PHYS,
  "Pyro%": VariableStat.PYRO
});