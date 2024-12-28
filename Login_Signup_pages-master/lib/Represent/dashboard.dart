import 'package:flutter/material.dart';
import 'sidebar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF2FCB85),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const Drawer(), // Exemple de Sidebar si nécessaire
      body: Stack(
        children: [
          // Arrière-plan bleu transparent
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Contenu principal
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Résumé des Marchés',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                // Premier résumé des marchés
                _buildMarketSection(
                  context,
                  title: "Indices mondiaux",
                  markets: [
                    _buildMarketCard('CAC 40', '7 355,37 EUR', '+1,00%', Colors.green),
                    _buildMarketCard('SBF 120', '5 570,33 EUR', '+0,99%', Colors.green),
                    _buildMarketCard('S&P 500', '5 970,8 EUR', '-1,11%', Colors.red),
                  ],
                ),
                const SizedBox(height: 16),
                // Deuxième résumé des marchés
                _buildMarketSection(
                  context,
                  title: "Crypto-monnaies",
                  markets: [
                    _buildMarketCard('Bitcoin', '27 000 USD', '+3,12%', Colors.green),
                    _buildMarketCard('Ethereum', '1 800 USD', '+2,43%', Colors.green),
                    _buildMarketCard('Ripple', '0,50 USD', '-0,87%', Colors.red),
                  ],
                ),
                const SizedBox(height: 16),
                // Troisième résumé des marchés
                _buildMarketSection(
                  context,
                  title: "Actions européennes",
                  markets: [
                    _buildMarketCard('Airbus', '125 EUR', '+1,75%', Colors.green),
                    _buildMarketCard('TotalEnergies', '54 EUR', '-0,32%', Colors.red),
                    _buildMarketCard('BNP Paribas', '59 EUR', '+0,85%', Colors.green),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Idées de la communauté',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIdeaButton('Choix de la rédaction'),
                    _buildIdeaButton('Pour vous'),
                    _buildIdeaButton('Suivis'),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Actions Gagnantes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                _buildWinningStocksList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketSection(BuildContext context,
      {required String title, required List<Widget> markets}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: markets
                .map((marketCard) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: marketCard,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketCard(String title, String value, String change, Color changeColor) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdeaButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2C2C2C).withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildWinningStocksList() {
    final stocks = [
      {'name': "TRONIC'S MICROSYSTEMS", 'ticker': 'ALTRO', 'price': '5,00 EUR', 'change': '+48,81%'},
      {'name': 'CRYPTO BLOCKCHAIN INDUS.', 'ticker': 'ALCBI', 'price': '0,2030 EUR', 'change': '+21,92%'},
      {'name': 'MADE', 'ticker': 'MLMAD', 'price': '11,00 EUR', 'change': '+18,99%'},
      {'name': 'HOPENING', 'ticker': 'MLHPE', 'price': '8,40 EUR', 'change': '+18,31%'},
      {'name': 'TERACT S.A.', 'ticker': 'TRACT', 'price': '1,036 EUR', 'change': '+17,10%'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: Text(
              stock['name']![0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            stock['name']!,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            stock['ticker']!,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock['price']!,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                stock['change']!,
                style: TextStyle(
                  color: stock['change']!.startsWith('+') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
