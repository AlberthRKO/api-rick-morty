import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prueba/models/characters.dart';

class HomePageMap extends StatefulWidget {
  const HomePageMap({super.key});

  @override
  State<HomePageMap> createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  List<Character>? characters;

  @override
  void initState() {
    super.initState();
    getDatos();
  }

  Future<void> getDatos() async {
    try {
      final response =
          await Dio().get("https://rickandmortyapi.com/api/character");
      setState(() {
        characters = (response.data['results'] as List)
            .map((character) => Character.fromJson(character))
            .toList();
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetching datos")),
      body: Center(
        child: characters != null
            ? ListView.builder(
                itemCount: characters!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(characters![index].name ?? 'No hay datos'),
                    leading: characters![index].image.isNotEmpty
                        ? Image.network(
                            characters![index].image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    subtitle: Text('Status: ${characters![index].status}'),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
