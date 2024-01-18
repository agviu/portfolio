import 'package:portfolio/models/assets/asset.dart';
import 'dart:convert';
import 'package:portfolio/models/time_mode.dart';
import 'package:portfolio/models/assets/asset_date.dart';

/// Represents a list of assets.
class AssetList {
  /// Constructor that initializes an AssetList with a list of assets.
  AssetList(this.assets);

  /// Factory constructor for creating an AssetList from JSON content.
  factory AssetList.fromJson(String jsonContent) {
    // Decode the JSON content into a dynamic variable.
    var content = jsonDecode(jsonContent);

    // Convert the decoded JSON content into a list of Asset objects.
    List<Asset> assets =
        (content as List).map((assetMap) => Asset.fromJson(assetMap)).toList();

    // Create and return an AssetList with the parsed list of assets.
    return AssetList(assets);
  }

  /// List of Asset objects stored in this AssetList.
  List<Asset> assets;

  /// Method to get the length (number of assets) in the AssetList.
  int length() {
    return assets.length;
  }

  /// Sorts the [assets] list. The first item [0] will be the Asset with the higher value
  /// for the given date. The last item [assets.length] will be the Asset with the
  /// lower value for the given date.
  ///
  /// [date] is the time to check, which depends on [mode]. If [mode] is yearWeek,
  /// then [date] will be something like YEAR.WEEK-YEAR. E.g: 2023.29
  sortByHigherValueOnDate(AssetDate assetDate) {
    assets.sort(
      (a, b) {
        if (a.price(assetDate).getValue() > b.price(assetDate).getValue()) {
          return -1;
        } else if (a.price(assetDate).getValue() <
            b.price(assetDate).getValue()) {
          return 1;
        }
        return 0;
      },
    );
  }

  /// Sorts a list of assets by their growth in value since a specific date.
  ///
  /// This function sorts assets based on the increase in their price since a given date.
  /// The assets are sorted in descending order of their growth, meaning the asset with
  /// the greatest increase in price is placed first.
  ///
  /// Arguments:
  /// - [date]: The reference date from which the growth in price is measured.
  /// - [dateBack]: The number of intervals to go back from the reference date to get the initial date for comparison.
  ///
  /// The sorting is based on the difference in asset prices between the first date derived from going back [dateBack] intervals
  /// from [date] and the last date in the generated list of dates.
  ///
  /// Usage:
  /// ```
  /// // Example: Sort assets based on their growth over the past 10 weeks from a specific date.
  /// sortAssetsByGrowthSinceDate('2023.10', 10);
  /// ```
  sortAssetsByGrowthSinceDate(AssetDate firstDate, int dateBack) {
    final dates = firstDate.getLatestsDates(dateBack);
    final lastDate = dates.last;

    assets.sort(
      (a, b) {
        var aDifference =
            a.price(firstDate).getValue() - a.price(lastDate).getValue();
        var bDifference =
            b.price(firstDate).getValue() - b.price(lastDate).getValue();

        if (aDifference > bDifference) {
          // print(
          //     '${a.code} on $firstDate <-> $lastDate difference is $aDifference');
          // print(
          //     '${b.code} on $firstDate <-> $lastDate difference is $bDifference');
          // print("Compared: ${aDifference - bDifference} ");
          // print(" ");
          return -1;
        } else if (aDifference < bDifference) {
          // print(
          //     '${b.code} on $firstDate <-> $lastDate difference is $bDifference');
          // print(
          //     '${a.code} on $firstDate <-> $lastDate difference is $aDifference');
          // print("Compared: ${bDifference - aDifference} ");
          // print(" ");
          return 1;
        }
        return 0;
      },
    );
  }
}
