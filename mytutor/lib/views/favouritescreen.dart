import 'package:flutter/material.dart';


class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Favourite'),
      ),
        body: Center(
          child: Container(
            child: Text('Favourite'),
          ),
        ),
    );
  }
}