import 'package:flutter/material.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/accounts_provider.dart';
import 'package:gibt_1/providers/characters_provider.dart';
import 'package:gibt_1/providers/data_provider.dart';
import 'package:gibt_1/providers/home_provider.dart';
import 'package:gibt_1/providers/weapons_provider.dart';
import 'package:gibt_1/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<DataProvider, CharactersProvider>(
            create: (_) => CharactersProvider(),
            update: (_, characters, previousState) => previousState!
              ..updatesFromDataProvider(characters.characters, previousState)),
        ChangeNotifierProxyProvider<DataProvider, WeaponsProvider>(
            create: (_) => WeaponsProvider(),
            update: (_, characters, previousState) => previousState!
              ..updatesFromDataProvider(characters.weapons, previousState)),
        ChangeNotifierProvider(
          create: (_) => AccountsProvider(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<DataProvider, AccountCharactersProvider>(
            create: (_) => AccountCharactersProvider(),
            update: (_, data, previousState) =>
                previousState!..updatesFromDataProvider(data, previousState)),
        ChangeNotifierProxyProvider<AccountCharactersProvider, HomeProvider>(
            create: (_) => HomeProvider(),
            update: (_, accountCharacters, previousState) => previousState!
              ..updatesFromAccountCharacters(accountCharacters, previousState))
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'main',
      routes: {
        'main': (_) => const MainScreen(),
        'character_form': (_) => const CharacterFormScreen(),
        'character_info': (_) => const CharacterInfoScreen(),
        'weapon_info': (_) => const WeaponInfoScreen(),
        'character_weapon_select': (_) => const CharacterWeaponSelectScreen(),
        'farming_material_details': (_) => const FarmingMaterialDetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.indigo,
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
        ),
      ),
    );
  }
}
