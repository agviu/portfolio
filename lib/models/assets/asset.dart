import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/time_mode.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/models/assets/asset_date.dart';

/// The `Asset` class represents a financial asset, which could be a cryptocurrency,
/// stock, commodity, etc. It holds various properties of the asset such as its unique code,
/// a map of its prices at different dates, its category, and the time mode for its pricing data.

class Asset {
  /// A unique identifier for the asset, typically a ticker symbol or code.
  final String code;

  /// A map that associates `AssetDate` objects with their corresponding `AssetPrice`.
  /// This allows for tracking the price of the asset at various dates.
  final Map<AssetDate, AssetPrice> prices;

  /// The category of the asset, which defaults to cryptocurrency if not specified.
  /// This could be expanded to include other categories such as equities, bonds, etc.
  final Category category;

  /// The mode of time measurement for the asset's pricing data, defaulting to year-week format.
  /// This determines how the dates in the `prices` map are interpreted.
  final TimeMode mode;

  /// Constructs an `Asset` with the given properties.
  ///
  /// Args:
  ///   code (String): The unique code or identifier for the asset.
  ///   prices (Map<AssetDate, AssetPrice>): A map of prices with dates.
  ///   category (Category): The category of the asset, with a default of `Category.crypto`.
  ///   mode (TimeMode): The time mode for the asset's pricing data, with a default of `TimeMode.yearWeek`.
  const Asset({
    required this.code,
    required this.prices,
    this.category = Category.crypto,
    this.mode = TimeMode.yearWeek,
  });

  /// A factory constructor for creating a new `Asset` instance from a JSON map.
  ///
  /// This constructor is used to deserialize a JSON object that contains the asset's data,
  /// including its code, prices at different dates, category, and time mode.
  ///
  /// Args:
  ///   jsonContent (Map<String, dynamic>): The JSON map containing the asset data.
  ///
  /// Returns:
  ///   Asset: A new `Asset` instance populated with data from the JSON map.
  factory Asset.fromJson(Map<String, dynamic> jsonContent) {
    // Parse the price list from the JSON content.
    // It is assumed that 'prices' is a list of maps containing date and price information.
    var priceList = jsonContent['prices'] as List;
    Map<AssetDate, AssetPrice> pricesMap = {};

    final TimeMode mode;

    // Check if 'mode' is provided in the JSON, otherwise use the default value.
    if (jsonContent.containsKey('mode') && jsonContent['mode'] != null) {
      mode = stringToTimeMode(jsonContent['mode']);
    } else {
      // Default time mode if not specified in the JSON.
      mode = TimeMode.yearWeek;
    }

    // Convert each price data in the list to an entry in the prices map.
    for (var pricesData in priceList) {
      pricesMap[AssetDate(pricesData[timeModeToString(mode)])] =
          AssetPrice(pricesData["value"].toDouble(), mode: mode);
    }

    // Create a new Asset instance using the parsed data.
    return Asset(
      code: jsonContent['code'], // The asset's code.
      prices: pricesMap, // The map of prices.
      category:
          stringToCategory(jsonContent['category']), // The asset's category.
      mode: mode, // The time mode for the asset's pricing data.
    );
  }

  /// Retrieves the price of the asset for a given date. If the price for the specified
  /// date is not available, an estimated price is calculated, stored, and returned.
  ///
  /// Args:
  ///   assetDate (AssetDate): The date for which the price is requested.
  ///   mode (TimeMode): [Optional] The time mode to be used. Defaults to `TimeMode.yearWeek`
  ///                    if not provided. Currently, this parameter is not used within the method,
  ///                    but it could be relevant for future enhancements or overloads.
  ///
  /// Returns:
  ///   AssetPrice: The price of the asset at the given date. This can be a previously
  ///   stored price or an estimated price if no price was stored for that date.
  AssetPrice price(AssetDate assetDate, [TimeMode mode = TimeMode.yearWeek]) {
    // Check if the price for the given date is already available in the prices map.
    if (prices[assetDate] == null) {
      // If not available, estimate the price, store it in the map, and then return it.
      // The estimatePriceValue method would be responsible for calculating the estimated price.
      prices[assetDate] = AssetPrice.estimated(estimatePriceValue(assetDate));
    }

    // Return the price for the given date, which is now guaranteed to be non-null.
    // The `!` operator is used to cast away nullability, as we're sure there's a value after the check above.
    return prices[assetDate]!;
  }

  /// Estimates the price value for the given asset date.
  /// The estimation is based on linear interpolation between the known real prices
  /// before and after the given date. It assumes that the price changes linearly over time.
  ///
  /// Throws:
  ///   - ArgumentError if the provided date is beyond the range of known real prices.
  ///
  /// Args:
  ///   assetDate (AssetDate): The date for which the price is to be estimated.
  ///
  /// Returns:
  ///   double: The estimated price value for the given date.
  double estimatePriceValue(AssetDate assetDate) {
    // First, identify the highest date with a real value that we have recorded.
    final highestDate = getHighestDateWithRealValue();
    // If the given date is beyond the highest date with a real value, throw an error.
    if (assetDate.dateTime.compareTo(highestDate.dateTime) > 0) {
      throw ArgumentError(
          "The provided date is higher than expected and we cannot give an estimation: $assetDate");
    }

    // Similarly, identify the lowest date with a real value.
    final lowestDate = getLowestDateWithRealValue();
    // If the given date is before the lowest date with a real value, throw an error.
    if (assetDate.dateTime.compareTo(lowestDate.dateTime) < 0) {
      throw ArgumentError(
          "The provided date is lower than expected and we cannot give an estimation: $assetDate");
    }

    // Count how many periods we have to go up to reach the next real value in the future.
    int upHops = 0;
    AssetDate nextDate = assetDate;
    // Iterate through the dates until we find a real value or reach the highest known date.
    while (nextDate != highestDate) {
      upHops++;
      nextDate = nextDate.getNextDate();
      // Check if the next date has a real price recorded, if so, break the loop.
      if (prices[nextDate] != null && prices[nextDate]!.isReal()) {
        break;
      }
    }

    // Similarly, count how many periods we have to go down to reach the previous real value.
    int downHops = 0;
    AssetDate previousDate = assetDate;
    // Iterate through the dates until we find a real value or reach the lowest known date.
    while (previousDate != lowestDate) {
      downHops++;
      previousDate = previousDate.getPreviousDate();
      // Check if the previous date has a real price recorded, if so, break the loop.
      if (prices[previousDate] != null && prices[previousDate]!.isReal()) {
        break;
      }
    }

    // Retrieve the real values for the next and previous dates.
    double upValue = prices[nextDate]!.getRealValue()!;
    double downValue = prices[previousDate]!.getRealValue()!;

    // Perform linear interpolation to estimate the value for the given date.
    double estimatedValue =
        ((upValue - downValue) / (upHops + downHops)) * downHops + downValue;

    return estimatedValue;
  }

  /// Gets the most recent date with real price information.
  ///
  /// This method iterates through the keys of the `prices` map, which are `AssetDate` objects,
  /// and identifies the one that represents the most recent date (i.e., the highest date)
  /// with real price information.
  ///
  /// Throws:
  ///   - StateError if the `prices` map is empty and no date can be returned.
  ///
  /// Returns:
  ///   AssetDate: The most recent `AssetDate` that contains real price data.
  AssetDate getHighestDateWithRealValue() {
    // Check if the prices map is empty and throw an error if so.
    if (prices.isEmpty) {
      throw StateError("The prices map is empty.");
    }

    // Start with the first date as the highest and compare with others to find the most recent.
    AssetDate highestKey = prices.keys.first;
    for (AssetDate key in prices.keys) {
      // If the current key is more recent than the stored highest, update the highest.
      if (key.dateTime.compareTo(highestKey.dateTime) > 0) {
        highestKey = key;
      }
    }

    // Return the date that is the most recent.
    return highestKey;
  }

  /// Gets the oldest date with real price information.
  ///
  /// Similar to `getHighestDateWithRealValue`, this method goes through the `prices` map
  /// to find the `AssetDate` that is the oldest (i.e., the lowest date) with real price data.
  ///
  /// Throws:
  ///   - StateError if the `prices` map is empty and no date can be returned.
  ///
  /// Returns:
  ///   AssetDate: The oldest `AssetDate` that contains real price data.
  AssetDate getLowestDateWithRealValue() {
    // Ensure there are prices to evaluate, otherwise throw an error.
    if (prices.isEmpty) {
      throw StateError("The prices map is empty.");
    }

    // Initialize the lowest date as the first key and search for any older dates.
    AssetDate lowestKey = prices.keys.first;
    for (AssetDate key in prices.keys) {
      // If a key is older than the current lowest, it becomes the new lowest.
      if (key.dateTime.compareTo(lowestKey.dateTime) < 0) {
        lowestKey = key;
      }
    }

    // After checking all keys, return the oldest date.
    return lowestKey;
  }
}
