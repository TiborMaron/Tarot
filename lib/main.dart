import 'package:flutter/material.dart';
import 'pages/test_page.dart';
import 'pages/draw_card_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(64, 224, 208, 1),
          brightness: Brightness.light,
          primary: const Color.fromARGB(255, 98, 231, 218),
          surface: const Color.fromRGBO(175, 238, 238, 1),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Tarot'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    DrawCard(),
    Placeholder(),
    Placeholder(),
    const TestPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //   title: Text(widget.title),
          // ),
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  extended: constraints.maxWidth >= 800,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Draw Card'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history),
                      label: Text('History'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.collections_bookmark),
                      label: Text('Cards'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.build),
                      label: Text('Test'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: pages[selectedIndex],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
