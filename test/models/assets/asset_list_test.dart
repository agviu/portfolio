import 'package:portfolio/models/assets/asset_list.dart';
import 'package:test/test.dart';

void main() {
  const json_content = """
  [
    {
        "code": "ADA",
        "prices": [
            {
                "timestamp": "2023-09-03T00:00:00",
                "value": 44223.52
            },
            {
                "timestamp": "2022-04-18T00:00:00",
                "value": 40442.29
            },
            {
                "timestamp": "2022-08-03T00:00:00",
                "value": 13596.89
            },
            {
                "timestamp": "2021-07-10T00:00:00",
                "value": 47930.12
            },
            {
                "timestamp": "2021-11-28T00:00:00",
                "value": 41444.35
            }
        ],
        "category": "crypto"
    },
    {
        "code": "XRP",
        "prices": [
            {
                "timestamp": "2023-06-20T00:00:00",
                "value": 11149.62
            },
            {
                "timestamp": "2023-02-08T00:00:00",
                "value": 5008.12
            },
            {
                "timestamp": "2022-09-26T00:00:00",
                "value": 1643.61
            },
            {
                "timestamp": "2023-03-17T00:00:00",
                "value": 14529.69
            },
            {
                "timestamp": "2021-05-28T00:00:00",
                "value": 18414.12
            }
        ],
        "category": "crypto"
    },
    {
        "code": "BNB",
        "prices": [{"timestamp": "2023-09-03T00:00:00", "value": 98011}, {"timestamp": "2022-04-18T06:00:00", "value": 30931}, {"timestamp": "2022-08-03T12:00:00", "value": 28488}, {"timestamp": "2023-09-03T18:00:00", "value": 59343}, {"timestamp": "2022-08-03T00:00:00", "value": 6029}],
        "category": "crypto"
    },
    {
        "code": "BTC",
        "prices": [{"timestamp": "2023-09-03T00:00:00", "value": 59208}, {"timestamp": "2023-09-03T18:00:00", "value": 87381}, {"timestamp": "2021-11-28T00:00:00", "value": 26637}, {"timestamp": "2022-04-18T06:00:00", "value": 85711}, {"timestamp": "2023-09-03T06:00:00", "value": 86601}],
        "category": "crypto"
    },
    {
        "code": "DOT",
        "prices": [{"timestamp": "2021-11-28T00:00:00", "value": 62951}, {"timestamp": "2021-07-10T12:00:00", "value": 2371}, {"timestamp": "2021-11-28T00:00:00", "value": 4229}, {"timestamp": "2021-07-10T00:00:00", "value": 95086}, {"timestamp": "2023-09-03T06:00:00", "value": 73847}],
        "category": "stock"
    },
    {
        "code": "ETH",
        "prices": [
            {
                "timestamp": "2021-07-10T12:00:00",
                "value": 98115
            },
            {
                "timestamp": "2022-04-18T12:00:00",
                "value": 73015
            },
            {
                "timestamp": "2022-04-18T18:00:00",
                "value": 2111
            },
            {
                "timestamp": "2021-07-10T12:00:00",
                "value": 19976
            },
            {
                "timestamp": "2022-08-03T12:00:00",
                "value": 2
            }
        ],
        "category": "stock"
    }
  ]
  """;

  test('Creates a list of assets from a valid JSON string', () {
    try {
      final AssetList asset_list = AssetList.fromJson(json_content);
      print(asset_list);
    } catch (e) {
      fail(
          'The creation of AssetList from a JSON failed with the exception: $e');
    }
  });
}
