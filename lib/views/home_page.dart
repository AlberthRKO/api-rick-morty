import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? characters;

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
        characters = response.data['results'];
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
                    title: Text(characters![index]['name'] ?? 'No hay datos'),
                    leading: characters![index]['image'] != null
                        ? Image.network(
                            characters![index]['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
