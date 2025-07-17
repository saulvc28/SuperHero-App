import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroMoreDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superHero;

  const SuperheroMoreDetailScreen({super.key, required this.superHero});

  @override
  Widget build(BuildContext context) {
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
        title: Text("Detalles - ${superHero.name}"),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del héroe
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    superHero.url,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
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

              // Información básica
              _buildSectionTitle("Información General"),
              _buildInfoCard([
                _buildInfoRow("Nombre", superHero.name),
                _buildInfoRow("Nombre Real", superHero.realName),
                _buildInfoRow("Raza", superHero.raza),
                _buildInfoRow("Primera Aparición", superHero.firstAppearance),
                _buildInfoRow("Editorial", superHero.publisher),
              ]),

              SizedBox(height: 20),

              // Biografía
              _buildSectionTitle("Biografía"),
              _buildInfoCard([
                _buildInfoRow("Nombre Completo", superHero.realName),
                _buildInfoRow("Alter Egos", superHero.alterEgos),
                _buildInfoRow("Alias", _formatList(superHero.alias)),
                _buildInfoRow("Lugar de Nacimiento", superHero.placeOfBirth),
              ]),

              SizedBox(height: 20),

              // Apariencia
              _buildSectionTitle("Apariencia"),
              _buildInfoCard([
                _buildInfoRow("Género", superHero.gender),
                _buildInfoRow("Altura", _formatList(superHero.height)),
                _buildInfoRow("Peso", _formatList(superHero.weight)),
              ]),

              SizedBox(height: 20),

              // Trabajo
              _buildSectionTitle("Trabajo"),
              _buildInfoCard([
                _buildInfoRow("Ocupación", superHero.occupation),
                _buildInfoRow("Base", superHero.base),
              ]),

              SizedBox(height: 20),

              // Conexiones
              _buildSectionTitle("Conexiones"),
              _buildInfoCard([
                _buildInfoRow("Familiares", superHero.relatives),
              ]),

              SizedBox(height: 20),

              // Estadísticas de poder
              _buildSectionTitle("Estadísticas de Poder"),
              _buildPowerStatsCard(),

              SizedBox(height: 30),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
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
            _buildPowerStatRow(
              "Inteligencia",
              superHero.powerStatsResponse.intelligence,
              Color(0xff4300FF),
            ),
            _buildPowerStatRow(
              "Fuerza",
              superHero.powerStatsResponse.strength,
              Color(0xffFF0B55),
            ),
            _buildPowerStatRow(
              "Velocidad",
              superHero.powerStatsResponse.speed,
              Color(0xff06D001),
            ),
            _buildPowerStatRow(
              "Durabilidad",
              superHero.powerStatsResponse.durability,
              Color(0xff810CA8),
            ),
            _buildPowerStatRow(
              "Poder",
              superHero.powerStatsResponse.power,
              Color(0xffFF4C29),
            ),
            _buildPowerStatRow(
              "Combate",
              superHero.powerStatsResponse.combat,
              Color(0xff735F32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerStatRow(String label, String? value, Color color) {
    double statValue = _parsePowerStat(value);

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
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: statValue / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  statValue.toStringAsFixed(0),
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _parsePowerStat(String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return 0.0;
    }

    try {
      double parsed = double.parse(value);
      return parsed.clamp(0.0, 100.0);
    } catch (e) {
      return 0.0;
    }
  }

  String _formatList(dynamic list) {
    if (list == null) {
      return "Desconocido";
    }

    // Si es un string, simplemente retornarlo
    if (list is String) {
      return list.isEmpty ? "Desconocido" : list;
    }

    // Si es una lista
    if (list is List) {
      if (list.isEmpty) {
        return "Desconocido";
      }
      // Convertir todos los elementos a string y filtrar los vacíos
      List<String> stringList = list
          .map((item) => item.toString())
          .where((item) => item.isNotEmpty && item != 'null')
          .toList();

      return stringList.isEmpty ? "Desconocido" : stringList.join(", ");
    }

    return "Desconocido";
  }
}
