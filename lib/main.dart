import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/rickandmorty_viewmodel.dart';
import 'screens/characters_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RickAndMortyViewModel()),
      ],
      child: MaterialApp(
        title: 'Rick and Morty Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          // Eliminamos cardTheme de aquí
        ),
        home: const CharactersListScreen(),
      ),
    );
  }
}
