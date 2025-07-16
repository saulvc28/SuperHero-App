import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superHero;
  const SuperheroDetailScreen({super.key, required this.superHero});

  // Método helper para parsear stats de manera segura
  double parsePowerStat(String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return 0.0;
    }

    try {
      double parsed = double.parse(value);
      // Limitar entre 0 y 100 para que las barras se vean bien
      return parsed.clamp(0.0, 100.0);
    } catch (e) {
      print('Error parsing power stat: $value -> $e');
      return 0.0;
    }
  }

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
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenHeight * 0.45,
                      child: Icon(Icons.error, size: 100),
                    );
                  },
                ),
                Text(
                  superHero.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  superHero.realName ?? 'Desconocido',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  superHero.firstAppearance ?? 'Desconocido',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  superHero.publisher ?? 'Desconocido',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  superHero.alignment ?? 'Desconocido',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildPowerStatBar(
                        parsePowerStat(
                          superHero.powerStatsResponse.intelligence,
                        ),
                        "Inteligencia",
                        Colors.lightBlue,
                      ),
                      _buildPowerStatBar(
                        parsePowerStat(superHero.powerStatsResponse.strength),
                        "Fuerza",
                        Colors.red,
                      ),
                      _buildPowerStatBar(
                        parsePowerStat(superHero.powerStatsResponse.speed),
                        "Velocidad",
                        Colors.lightGreenAccent,
                      ),
                      _buildPowerStatBar(
                        parsePowerStat(superHero.powerStatsResponse.durability),
                        "Durabilidad",
                        Colors.green,
                      ),
                      _buildPowerStatBar(
                        parsePowerStat(superHero.powerStatsResponse.power),
                        "Poder",
                        Colors.redAccent,
                      ),
                      _buildPowerStatBar(
                        parsePowerStat(superHero.powerStatsResponse.combat),
                        "Combate",
                        Colors.grey,
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

  Widget _buildPowerStatBar(double value, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height:
              value * 2, // Multiplicar por 2 para hacer las barras más visibles
          width: 20,
          color: color,
          child: value == 0
              ? Container(height: 10, width: 20, color: Colors.grey.shade300)
              : null,
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
        Text(
          value.toStringAsFixed(0),
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}
