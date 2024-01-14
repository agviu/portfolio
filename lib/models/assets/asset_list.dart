import 'package:portfolio/models/assets/asset.dart';
import 'dart:convert';
import 'package:portfolio/models/time_mode.dart';

import 'package:portfolio/utils/dates.dart';

class AssetList {
  AssetList(this.assets);

  factory AssetList.fromJson(String jsonContent) {
    var content = jsonDecode(jsonContent);

    List<Asset> assets =
        (content as List).map((assetMap) => Asset.fromJson(assetMap)).toList();
    return AssetList(assets);
  }

  List<Asset> assets;

  int length() {
    return assets.length;
  }

  /// Sorts the [assets] list. The first item [0] will be the Asset with the higher value
  /// for the given date. The last item [assets.length] will bethe Asset with the
  /// lower value for the given date.
  ///
  /// [date] is the time to check, which depends on [mode]. If [mode] is yearWeek,
  /// then [date] will be something like YEAR.WEEK-YEAR. E.g: 2023.29
  sortByHigherValueOnDate(String date, [TimeMode mode = TimeMode.yearWeek]) {
    assets.sort(
      (a, b) {
        if (a.price(date, mode).getValue() > b.price(date, mode).getValue()) {
          return -1;
        } else if (a.price(date, mode).getValue() <
            b.price(date, mode).getValue()) {
          return 1;
        }
        return 0;
      },
    );
  }

  // sortByGreaterGrowthOnDate(String date, int dateBack,
  //     [TimeMode mode = TimeMode.yearWeek]) {
  //   final dates = DateUtils.getLatestsDates(dateBack, mode: mode, from: date);
  //   final firstDate = dates.first;
  //   final lastDate = dates.last;

  //   assets.sort((a, b) {
  //     if (a.price(firstDate) == null && a.price()) {}
  //     return 0;
  //   });
  // }
}
