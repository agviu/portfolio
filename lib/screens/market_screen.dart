import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';
import 'package:flutter/services.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late AssetList assetList;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Replace this with your actual data fetching logic
      assetList = await _loadAssets();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load assets: ${e.toString()}';
      });
    }
  }

  Future<AssetList> _loadAssets() async {
    String jsonString =
        await rootBundle.loadString('assets/data/asset_list.json');
    return AssetList.fromJson(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : RefreshIndicator(
                  onRefresh: _fetchAssets,
                  child: AssetListWidget(assetList: assetList),
                ),
    );
  }
}
