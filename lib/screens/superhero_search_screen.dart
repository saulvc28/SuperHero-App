import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';
import 'package:superhero_app/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repository _repository = Repository();
  bool _isTextEmpty = true; // solucionamos el error del api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(25),
            //   bottomRight: Radius.circular(25),
            // ),
            gradient: LinearGradient(
              colors: <Color>[Color(0xff2B3467), Color(0xffEB455F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("SuperHero Search"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xffEEEEEE),
              Color(0xffFFFFFF),
            ], //Color(0xffFCFFE7), Color(0xffBAD7E9)
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Busca tu Superhéroe favorito!",
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xffF32424),
                      width: 2,
                    ), // Borde al enfocarse
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _isTextEmpty = text.isEmpty;
                    _superheroInfo = _repository.fetchSuperheroInfo(text);
                  });
                },
              ),
            ),
            bodyList(_isTextEmpty),
          ],
        ),
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList(bool isTextEmpty) {
    return FutureBuilder(
      future: _superheroInfo,
      builder: (context, snapshot) {
        if (_isTextEmpty) {
          return Center(child: Text("Introduce un Héroe a buscar."));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircularProgressIndicator con colores personalizados
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xffEB455F),
                    ),
                    backgroundColor: Colors.grey[300],
                    strokeWidth: 4,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Buscando superhéroes...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff2B3467),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superheroList != null) {
                  return itemSuperhero(superheroList[index]);
                } else {
                  return Text("Error al cargar los datos!");
                }
              },
            ),
          );
        } else {
          return Text("No hubo resultados!");
        }
      },
    );
  }

  GestureDetector itemSuperhero(SuperheroDetailResponse item) =>
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuperheroDetailScreen(superHero: item),
          ),
        ),
        child: Column(
          children: [
            Image.network(item.url, height: 400),
            Padding(
              padding: const EdgeInsets.only(top: 0.5, bottom: 20),
              child: Text(
                item.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
}
