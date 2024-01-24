import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/widgets/market/asset_prices_widget.dart';

class AssetWidget extends StatelessWidget {
  const AssetWidget({super.key, required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssetPricesWidget(
              asset: asset,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0, // Add some elevation for better visual effect
        margin: const EdgeInsets.all(8.0), // Add margin for spacing
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            children: [
              Text(
                asset.code,
                style: const TextStyle(
                  fontSize: 20.0, // Larger font for the asset code
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              const SizedBox(height: 8.0), // Add space between the texts
              Text(
                'Category: ${asset.category}', // More descriptive text
                style: const TextStyle(fontSize: 16.0), // Slightly smaller font
              ),
              const SizedBox(height: 8.0), // Add space before the next element
              Text(
                'Time Mode: ${asset.mode}', // Display the time mode
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0), // Add space before the next element
              _buildPriceInfo(), // A method to build price information
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    // Check if there are prices to display
    if (asset.prices.isNotEmpty) {
      // Display the latest price info
      var latestDate = asset.getLatestDateWithRealValue();
      var latestPrice = asset.prices[latestDate];
      // print(latestPrice?.getValue().toStringAsFixed(2));
      return Text(
        'Latest Price: ${latestPrice?.getValue().toStringAsFixed(2)}', // Format the price
        style: const TextStyle(fontSize: 16.0),
      );
    } else {
      // Display a placeholder if no prices are available
      return const Text(
        'Price information not available',
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
      );
    }
  }
}
