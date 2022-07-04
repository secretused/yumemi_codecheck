// StatelessWidgetを継承して作成
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatelessWidget {
  Widget build(BuildContext context) {
    // バナー広告をインスタンス化
    BannerAd myBanner = BannerAd(
      adUnitId: getTestAdBannerUnitId(),
      //adUnitId: getAdBannerUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    // バナー広告の読み込み
    myBanner.load();
    return Container(
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
      child: AdWidget(ad: myBanner),
    );
  }

// プラットフォーム（iOS / Android）に合わせてデモ用広告IDを返す
  String getTestAdBannerUnitId() {
    String testBannerUnitId = "";
    if (Platform.isAndroid) {
      // Android のとき
      testBannerUnitId =
          "ca-app-pub-3940256099942544/6300978111"; // Androidのデモ用バナー広告ID
      //本番用ANDROIDバナーID
    } else if (Platform.isIOS) {
      // iOSのとき
      testBannerUnitId =
          "ca-app-pub-3940256099942544/2934735716"; // iOSのデモ用バナー広告ID
      //本番用IOSバナーID
    }
    return testBannerUnitId;
  }
}
