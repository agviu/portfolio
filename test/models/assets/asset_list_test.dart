import 'package:portfolio/models/assets/asset_list.dart';
import 'package:test/test.dart';

void main() {
  const json_content = """
  [
    {
        "code": "ADA",
        "prices": [
            {
                "year.week": "2020.38",
                "value": 66567
            },
            {
                "year.week": "2018.37",
                "value": 76448
            },
            {
                "year.week": "2018.13",
                "value": 96925
            },
            {
                "year.week": "2023.20",
                "value": 26436
            },
            {
                "year.week": "2022.36",
                "value": 98341
            }
        ],
        "category": "crypto",
        "mode": "year.week"
    },
    {
        "code": "SHIB",
        "prices": [
            {
                "year.week": "2020.1",
                "value": 88128
            },
            {
                "year.week": "2021.33",
                "value": 56051
            },
            {
                "year.week": "2022.11",
                "value": 95097
            },
            {
                "year.week": "2019.43",
                "value": 39633
            },
            {
                "year.week": "2020.1",
                "value": 91910
            }
        ],
        "category": "crypto",
        "mode": "year.week"
    },
    {
        "code": "XRP",
        "prices": [
            {
                "year.week": "2020.24",
                "value": 40285.57
            },
            {
                "year.week": "2022.1",
                "value": 45551.33
            },
            {
                "year.week": "2022.41",
                "value": 99996.69
            },
            {
                "year.week": "2020.39",
                "value": 80705.27
            },
            {
                "year.week": "2021.34",
                "value": 58275.39
            }
        ],
        "category": "crypto",
        "mode": "year.week"
    },
    {
        "code": "BNB",
        "prices": [
            {"year.week": "2019.43", "value": 32713.31},
            {"year.week": "2023.11", "value": 18751.15},
            {"year.week": "2019.22", "value": 70617.28},
            {"year.week": "2022.1", "value": 59174.05},
            {"year.week": "2022.51", "value": 5592.55}
        ],   
        "category": "crypto",
        "mode": "year.week"
    },
    {
        "code": "BTC",
        "prices": [
          {"year.week": "2018.30", "value": 41896.38},
          {"year.week": "2019.9", "value": 48798.57},
          {"year.week": "2022.1", "value": 52661.67},
          {"year.week": "2021.24", "value": 26885.34},
          {"year.week": "2023.44", "value": 67243.13}
        ],
        "category": "crypto",
        "mode": "year.week"
    },
    {
        "code": "DOT",
        "prices": [
            {"year.week": "2019.11", "value": 53888.23},
            {"year.week": "2021.1", "value": 95494.48},
            {"year.week": "2023.24", "value": 43549.87},
            {"year.week": "2021.36", "value": 50806.98},
            {"year.week": "2019.31", "value": 2348.07}
        ],
        "category": "stock",
        "mode": "year.week"
    },
    {
        "code": "ETH",
        "prices": [
            {"year.week": "2019.8", "value": 60984.21},
            {"year.week": "2020.22", "value": 49077.19},
            {"year.week": "2022.35", "value": 21276.15},
            {"year.week": "2018.17", "value": 86030.46},
            {"year.week": "2019.16", "value": 74311.23}
        ],
        "category": "stock",
        "mode": "year.week"
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
