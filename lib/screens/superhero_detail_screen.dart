import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/screens/superhero_more_detail_screen.dart';

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
      return parsed.clamp(0.0, 100.0);
    } catch (e) {
      print('Error parsing power stat: $value -> $e');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xffFF0303),
                Color(0xff7EACB5),
                Color(0xff2E3840),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("${superHero.name}"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xffEEEEEE), Color(0xffFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen del héroe
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    superHero.url,
                    height: 280,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.error, size: 50),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Información básica del héroe
              _buildInfoCard([
                _buildHeroTitle(superHero.name),
                SizedBox(height: 8),
                _buildHeroSubtitle(superHero.realName),
                SizedBox(height: 16),
                _buildInfoRow("Raza", superHero.raza),
                _buildInfoRow("Primera Aparición", superHero.firstAppearance),
                _buildInfoRow("Editorial", superHero.publisher),
                _buildInfoRow("Ocupación", superHero.occupation),
              ]),

              SizedBox(height: 20),

              // Botón para más información
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SuperheroMoreDetailScreen(superHero: superHero),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2E3840),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Ver información completa",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Estadísticas de poder
              _buildSectionTitle("Estadísticas de Poder"),
              _buildPowerStatsCard(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xff2E3840),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildHeroTitle(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xff2E3840),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildHeroSubtitle(String realName) {
    return Text(
      realName,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2E3840),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPowerStatsCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barras de poder horizontales
            _buildPowerStatRow(
              "Inteligencia",
              parsePowerStat(superHero.powerStatsResponse.intelligence),
              Color(0xff4300FF),
            ),
            _buildPowerStatRow(
              "Fuerza",
              parsePowerStat(superHero.powerStatsResponse.strength),
              Color(0xffFF0B55),
            ),
            _buildPowerStatRow(
              "Velocidad",
              parsePowerStat(superHero.powerStatsResponse.speed),
              Color(0xff06D001),
            ),
            _buildPowerStatRow(
              "Durabilidad",
              parsePowerStat(superHero.powerStatsResponse.durability),
              Color(0xff810CA8),
            ),
            _buildPowerStatRow(
              "Poder",
              parsePowerStat(superHero.powerStatsResponse.power),
              Color(0xffFF4C29),
            ),
            _buildPowerStatRow(
              "Combate",
              parsePowerStat(superHero.powerStatsResponse.combat),
              Color(0xff735F32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerStatRow(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2E3840),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: value / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
