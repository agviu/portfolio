import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For json decoding

import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';

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
      assetList = await _loadAssets();
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assets successfully downloaded!')),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load assets: ${e.toString()}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load assets: ${e.toString()}')),
      );
    }
  }

  Future<AssetList> _loadAssets() async {
    final url = Uri.parse(
        'https://investrends-7320c-default-rtdb.europe-west1.firebasedatabase.app/exporter.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        return AssetList.fromJson(response.body);
      } catch (e) {
        throw Exception('An error occurred: ${e.toString()}');
      }
    } else {
      throw Exception('Failed to load asset list');
    }
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
                  child: AssetListWidget(
                    assetList: assetList,
                    initialDate: AssetDate.dateTime(DateTime.now()),
                    //@todo: This is just for a test, return to normal
                    // initialDate: AssetDate("2023.48"),
                  ),
                ),
    );
  }
}
