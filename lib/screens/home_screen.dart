import 'package:flutter/material.dart';
import 'package:score_keeper/screens/new_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: MenuItemButton(
                    trailingIcon: Icon(
                      Icons.add_card,
                      color: Colors.green,
                    ),
                    child: Text(
                      "New Game",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ];
            },
            onSelected: (value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewGameScreen()));
            },
          ),
        ],
        title: const Text('Score Keeper'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("No games yet, tap to create a new one now!"),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewGameScreen()));
              },
              child: const Icon(
                Icons.add_circle,
                color: Colors.green,
                size: 75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
