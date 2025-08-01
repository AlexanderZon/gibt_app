import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/accounts_provider.dart';
import 'package:gibt_1/providers/characters_provider.dart';
import 'package:gibt_1/providers/weapons_provider.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CharacterFormScreen extends StatefulWidget {
  const CharacterFormScreen({Key? key}) : super(key: key);

  @override
  State<CharacterFormScreen> createState() => _CharacterFormScreenState();
}

class _CharacterFormScreenState extends State<CharacterFormScreen> {
  final Map<String, dynamic> modelFormSettings = {
    'tab': 0,
    'basicTalentMaxLevelToogle': false,
    'elementalTalentMaxLevelToogle': false,
    'burstTalentMaxLevelToogle': false,
  };

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    final accountCharactersProvider =
        Provider.of<AccountCharactersProvider>(context);

    final list = accountCharactersProvider.list;
    final modelList =
        list.where((element) => element.characterId == character.id);
    if (modelList.isEmpty) {
      final accountsProvider = Provider.of<AccountsProvider>(context);
      final account = accountsProvider.activeAccount;
      if (account != null) {
        AccountCharacter newAccountCharacter = AccountCharacter(
            accountId: account.id,
            characterId: character.id,
            weaponId: Weapon.defaultWeaponId(character.weaponType),
            level: '1',
            constellations: 0,
            basicTalentLevel: 1,
            basicTalentMaxLevel: 9,
            elementalTalentLevel: 1,
            elementalTalentMaxLevel: 9,
            burstTalentLevel: 1,
            burstTalentMaxLevel: 9,
            weapLevel: '1',
            weapRank: 1,
            isBuilding: false);
        accountCharactersProvider.store(newAccountCharacter);
      }

      return Container();
    }

    AccountCharacter actualModel = modelList.first;

    final List<String> characterLevels = [
      '1',
      '20',
      '20+',
      '40',
      '40+',
      '50',
      '50+',
      '60',
      '60+',
      '70',
      '70+',
      '80',
      '80+',
      '90'
    ];
    final List<String> weaponLevels = [
      '1',
      '20',
      '20+',
      '40',
      '40+',
      '50',
      '50+',
      '60',
      '60+',
      '70',
      '70+',
      '80',
      '80+',
      '90'
    ];
    final List<int> constellations = [0, 1, 2, 3, 4, 5, 6];
    final List<int> ranks = [1, 2, 3, 4, 5];
    final List<int> talentLevels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    final Map<String, dynamic> modelFormValues = {
      'level': actualModel.level,
      'constellations': actualModel.constellations,
      'basicTalentLevel': actualModel.basicTalentLevel,
      'basicTalentMaxLevel': actualModel.basicTalentMaxLevel,
      'elementalTalentLevel': actualModel.elementalTalentLevel,
      'elementalTalentMaxLevel': actualModel.elementalTalentMaxLevel,
      'burstTalentLevel': actualModel.burstTalentLevel,
      'burstTalentMaxLevel': actualModel.burstTalentMaxLevel,
      'weapLevel': actualModel.weapLevel,
      'weapRank': actualModel.weapRank,
      'isBuilding': actualModel.isBuilding,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Data'),
        actions: [
          _DeleteCharacterConfirmDialogButton(onDelete: () async {
            Navigator.pop(context);
            await Future.delayed(const Duration(milliseconds: 500));
            accountCharactersProvider.delete(actualModel);
          }),
        ],
      ),
      body: _CharacterFormScreenContent(
          actualModel: actualModel,
          characterLevels: characterLevels,
          weaponLevels: weaponLevels,
          modelFormValues: modelFormValues,
          modelFormSettings: modelFormSettings,
          constellations: constellations,
          ranks: ranks,
          talentLevels: talentLevels,
          accountCharactersProvider: accountCharactersProvider,
          onTab: (tab) {
            setState(() {
              modelFormSettings['tab'] = tab;
            });
          },
          onToogle: (property) {
            print('Toogle: $property');
            setState(() {
              modelFormSettings[property + 'Toogle'] =
                  !modelFormSettings[property + 'Toogle'];
            });
          }),
    );
  }
}

class _CharacterFormScreenContent extends StatelessWidget {
  const _CharacterFormScreenContent({
    super.key,
    required this.actualModel,
    required this.characterLevels,
    required this.weaponLevels,
    required this.modelFormValues,
    required this.modelFormSettings,
    required this.constellations,
    required this.ranks,
    required this.talentLevels,
    required this.accountCharactersProvider,
    required this.onTab,
    required this.onToogle,
  });

  final AccountCharacter actualModel;
  final List<String> characterLevels;
  final List<String> weaponLevels;
  final Map<String, dynamic> modelFormValues;
  final Map<String, dynamic> modelFormSettings;
  final List<int> constellations;
  final List<int> ranks;
  final List<int> talentLevels;
  final AccountCharactersProvider accountCharactersProvider;
  final Function onTab;
  final Function onToogle;

  void saveCharacterData() {
    actualModel.level = modelFormValues['level'];
    actualModel.constellations = modelFormValues['constellations'];
    actualModel.basicTalentLevel = modelFormValues['basicTalentLevel'];
    actualModel.basicTalentMaxLevel = modelFormValues['basicTalentMaxLevel'];
    actualModel.elementalTalentLevel = modelFormValues['elementalTalentLevel'];
    actualModel.elementalTalentMaxLevel =
        modelFormValues['elementalTalentMaxLevel'];
    actualModel.burstTalentLevel = modelFormValues['burstTalentLevel'];
    actualModel.burstTalentMaxLevel = modelFormValues['burstTalentMaxLevel'];
    actualModel.weapLevel = modelFormValues['weapLevel'];
    actualModel.weapRank = modelFormValues['weapRank'];
    actualModel.isBuilding = modelFormValues['isBuilding'];
    accountCharactersProvider.update(actualModel);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            _CharacterFormImageDisplayer(
                accountCharacter: actualModel,
                modelFormSettings: modelFormSettings,
                onTab: onTab),
            if (modelFormSettings['tab'] == 0)
              Column(children: [
                SliderOptionsPicker(
                    key: const Key("level"),
                    label: 'Charcter Level',
                    options: characterLevels,
                    formProperty: 'level',
                    formValues: modelFormValues,
                    onChange: saveCharacterData),
                SliderOptionsPicker(
                    key: const Key("constellations"),
                    label: 'Constellations',
                    options: constellations,
                    formProperty: 'constellations',
                    formValues: modelFormValues,
                    onChange: saveCharacterData),
                if (!modelFormSettings['basicTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("basicTalentLevel"),
                      label: 'Basic Talent Level',
                      options: talentLevels,
                      formProperty: 'basicTalentLevel',
                      formValues: modelFormValues,
                      slotActions: _maxTalentLevelViewer('basicTalent'),
                      onChange: saveCharacterData),
                if (modelFormSettings['basicTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("basicTalentMaxLevel"),
                      label: 'Basic Talent Max Level',
                      options: talentLevels,
                      formProperty: 'basicTalentMaxLevel',
                      formValues: modelFormValues,
                      color: Colors.red,
                      slotActions: _maxTalentLevelViewer('basicTalent'),
                      onChange: saveCharacterData),
                if (!modelFormSettings['elementalTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("elementalTalentLevel"),
                      label: 'Elemental Talent Level',
                      options: talentLevels,
                      formProperty: 'elementalTalentLevel',
                      formValues: modelFormValues,
                      slotActions: _maxTalentLevelViewer('elementalTalent'),
                      onChange: saveCharacterData),
                if (modelFormSettings['elementalTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("elementalTalentMaxLevel"),
                      label: 'Elemental Talent Max Level',
                      options: talentLevels,
                      formProperty: 'elementalTalentMaxLevel',
                      formValues: modelFormValues,
                      color: Colors.red,
                      slotActions: _maxTalentLevelViewer('elementalTalent'),
                      onChange: saveCharacterData),
                if (!modelFormSettings['burstTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("burstTalentLevel"),
                      label: 'Burst Talent Level',
                      options: talentLevels,
                      formProperty: 'burstTalentLevel',
                      formValues: modelFormValues,
                      slotActions: _maxTalentLevelViewer('burstTalent'),
                      onChange: saveCharacterData),
                if (modelFormSettings['burstTalentMaxLevelToogle'])
                  SliderOptionsPicker(
                      key: const Key("burstTalentMaxLevel"),
                      label: 'Burst Talent Level',
                      options: talentLevels,
                      formProperty: 'burstTalentMaxLevel',
                      formValues: modelFormValues,
                      color: Colors.red,
                      slotActions: _maxTalentLevelViewer('burstTalent'),
                      onChange: saveCharacterData),
              ])
            else if (modelFormSettings['tab'] == 1)
              Column(children: [
                SliderOptionsPicker(
                    key: const Key("weapLevel"),
                    label: 'Weapon Level',
                    options: weaponLevels,
                    formProperty: 'weapLevel',
                    formValues: modelFormValues,
                    onChange: saveCharacterData),
                SliderOptionsPicker(
                    key: const Key("weapRank"),
                    label: 'Weapon Refinement Rank',
                    options: ranks,
                    formProperty: 'weapRank',
                    formValues: modelFormValues,
                    onChange: saveCharacterData),
              ]),
            CustomSwitch(
                label: 'Is Building?: ',
                formProperty: 'isBuilding',
                formValues: modelFormValues,
                onChange: saveCharacterData),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _maxTalentLevelViewer(String property) {
    if (!modelFormSettings['${property}MaxLevelToogle']) {
      return GestureDetector(
        onTap: () => onToogle('${property}MaxLevel'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.red, width: 2),
            color: Colors.red.withOpacity(.25),
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            'Max Level: ${modelFormValues['${property}MaxLevel']}',
            style: const TextStyle(fontSize: 12, fontFamily: "Genshin"),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => onToogle('${property}MaxLevel'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.indigo, width: 2),
            color: Colors.indigo.withOpacity(.25),
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            'Actual Level: ${modelFormValues['${property}Level']}',
            style: const TextStyle(fontSize: 12, fontFamily: "Genshin"),
          ),
        ),
      );
    }
  }
}

class _DeleteCharacterConfirmDialogButton extends StatelessWidget {
  const _DeleteCharacterConfirmDialogButton(
      {
      // ignore: unused_element
      super.key,
      required this.onDelete});

  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return DeleteIconButtonDialog(
        title: 'Delete Character',
        content: 'Are you sure to delete this character?',
        onConfirm: () => onDelete());
  }
}

class _CharacterFormImageDisplayer extends StatefulWidget {
  final AccountCharacter accountCharacter;
  final Map<String, dynamic> modelFormSettings;
  final Function onTab;

  const _CharacterFormImageDisplayer({
    super.key,
    required this.accountCharacter,
    required this.modelFormSettings,
    required this.onTab,
  });

  @override
  State<_CharacterFormImageDisplayer> createState() =>
      _CharacterFormImageDisplayerState();
}

class _CharacterFormImageDisplayerState
    extends State<_CharacterFormImageDisplayer> {
  @override
  Widget build(BuildContext context) {
    final charactersProvider = Provider.of<CharactersProvider>(context);
    final weaponsProvider = Provider.of<WeaponsProvider>(context);

    final charactersList = charactersProvider.onDisplayCharacters;
    final weaponsList = weaponsProvider.onDisplayWeapons;

    final character = charactersList.firstWhere(
      (element) => element.id == widget.accountCharacter.characterId,
    );
    final weapon = weaponsList.firstWhere(
      (element) => element.id == widget.accountCharacter.weaponId,
    );

    const Color selectedColor = Colors.indigo;
    const double selectedBorderSize = 3;

    BoxFit weaponBoxFit = BoxFit.cover;
    if (weapon.weaponType == WeaponType.CATALYST) weaponBoxFit = BoxFit.contain;
    String weaponImageType = 'icon';
    if (widget.accountCharacter.weapLevel != '1' &&
        widget.accountCharacter.weapLevel != '20' &&
        widget.accountCharacter.weapLevel != '20+' &&
        widget.accountCharacter.weapLevel != '40')
      weaponImageType = 'awakened_icon';

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onTab(0),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: widget.modelFormSettings['tab'] == 0
                        ? selectedColor
                        : null,
                    padding: const EdgeInsets.all(selectedBorderSize),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/miscellaneous/${character.rarity}star.webp')),
                          ),
                          SizedBox(
                            height: double.infinity,
                            child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/characters/${character.id}_icon.webp')),
                          ),
                          Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  IconButton(
                                      onPressed: () {
                                        widget.onTab(0);
                                        Navigator.pushNamed(
                                            context, 'character_info',
                                            arguments: character);
                                      },
                                      icon: const Icon(
                                        Icons.info,
                                        size: 35,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 50)
                                        ],
                                      ))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onTab(1),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: widget.modelFormSettings['tab'] == 1
                        ? selectedColor
                        : null,
                    padding: const EdgeInsets.all(selectedBorderSize),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/miscellaneous/${weapon.rarity}star.webp')),
                          ),
                          SizedBox(
                            height: double.infinity,
                            child: Image(
                                fit: weaponBoxFit,
                                image: AssetImage(
                                    'assets/weapons/${weapon.id}_$weaponImageType.webp')),
                          ),
                          Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'character_weapon_select',
                                            arguments: widget.accountCharacter);
                                        widget.onTab(1);
                                      },
                                      icon: const Icon(
                                        Icons.swap_horizontal_circle_sharp,
                                        size: 35,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 50)
                                        ],
                                      )),
                                  Expanded(child: Container()),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'weapon_info',
                                            arguments: weapon);
                                        widget.onTab(1);
                                      },
                                      icon: const Icon(
                                        Icons.info,
                                        size: 35,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 50)
                                        ],
                                      ))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
