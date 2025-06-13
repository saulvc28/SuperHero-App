import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superHero;
  const SuperheroDetailScreen({super.key, required this.superHero});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xffFF0303), Color(0xff2E3840)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("${superHero.name} "),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        //agregamos a la vista un scroll
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xffEEEEEE), Color(0xffFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  superHero.url,
                  height: screenHeight * 0.45,
                ), // 40% de la pantalla
                Text(
                  superHero.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  superHero.realName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.intelligence,
                            ),
                            width: 20,
                            color: Colors.lightBlue,
                          ),
                          Text("Inteligencia"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.strength,
                            ),
                            width: 20,
                            color: Colors.red,
                          ),
                          Text("Fuerza"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.speed,
                            ),
                            width: 20,
                            color: Colors.lightGreenAccent,
                          ),
                          Text("Velocidad"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.durability,
                            ),
                            width: 20,
                            color: Colors.green,
                          ),
                          Text("Durabilidad"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.power,
                            ),
                            width: 20,
                            color: Colors.redAccent,
                          ),
                          Text("Poder"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: double.parse(
                              superHero.powerStatsResponse.combat,
                            ),
                            width: 20,
                            color: Colors.grey,
                          ),
                          Text("Combate"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
