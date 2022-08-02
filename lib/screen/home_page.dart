import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rickandmorty/model/character_model.dart';
import 'package:rickandmorty/screen/character_info.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://rickandmortyapi.com/api/character/";
  Character character;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    character = Character.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Persons list",
        ),
        actions: <Widget>[],
      ),
      body: ListView.builder(
        itemCount: character.results == null ? 0 : character.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (results) {
                    return CharDetail(
                      results: character.results[index],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: character.results[index].status == "Alive"
                      ? Colors.green
                      : Colors.red,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: character.results[index].status == "Alive"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: Image.network(
                        character.results[index].image,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        character.results[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
