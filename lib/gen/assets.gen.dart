/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsCategoriesGen {
  const $AssetsCategoriesGen();

  /// File path: assets/categories/appliances.png
  AssetGenImage get appliances =>
      const AssetGenImage('assets/categories/appliances.png');

  /// File path: assets/categories/books.png
  AssetGenImage get books => const AssetGenImage('assets/categories/books.png');

  /// File path: assets/categories/electronics.png
  AssetGenImage get electronics =>
      const AssetGenImage('assets/categories/electronics.png');

  /// File path: assets/categories/essential.png
  AssetGenImage get essential =>
      const AssetGenImage('assets/categories/essential.png');

  /// File path: assets/categories/fashion.png
  AssetGenImage get fashion =>
      const AssetGenImage('assets/categories/fashion.png');

  /// File path: assets/categories/home.png
  AssetGenImage get home => const AssetGenImage('assets/categories/home.png');

  /// File path: assets/categories/mobile.png
  AssetGenImage get mobile =>
      const AssetGenImage('assets/categories/mobile.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [appliances, books, electronics, essential, fashion, home, mobile];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/applepay.json
  String get applepay => 'assets/images/applepay.json';

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// File path: assets/images/empty_cart.png
  AssetGenImage get emptyCart =>
      const AssetGenImage('assets/images/empty_cart.png');

  /// File path: assets/images/facebook.svg
  String get facebook => 'assets/images/facebook.svg';

  /// File path: assets/images/food.png
  AssetGenImage get food => const AssetGenImage('assets/images/food.png');

  /// File path: assets/images/google.svg
  String get google => 'assets/images/google.svg';

  /// File path: assets/images/gpay.json
  String get gpay => 'assets/images/gpay.json';

  /// File path: assets/images/greentick.svg
  String get greentick => 'assets/images/greentick.svg';

  /// File path: assets/images/icon.png
  AssetGenImage get iconPng => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/icon.svg
  String get iconSvg => 'assets/images/icon.svg';

  /// File path: assets/images/image.jpg
  AssetGenImage get image => const AssetGenImage('assets/images/image.jpg');

  /// File path: assets/images/logo_normal.png
  AssetGenImage get logoNormal =>
      const AssetGenImage('assets/images/logo_normal.png');

  /// File path: assets/images/logo_rond.png
  AssetGenImage get logoRond =>
      const AssetGenImage('assets/images/logo_rond.png');

  /// File path: assets/images/logo_white.png
  AssetGenImage get logoWhite =>
      const AssetGenImage('assets/images/logo_white.png');

  /// File path: assets/images/navicon.svg
  String get navicon => 'assets/images/navicon.svg';

  /// File path: assets/images/no_orders.gif
  AssetGenImage get noOrders =>
      const AssetGenImage('assets/images/no_orders.gif');

  /// File path: assets/images/order_done.png
  AssetGenImage get orderDone =>
      const AssetGenImage('assets/images/order_done.png');

  /// File path: assets/images/shopit text.svg
  String get shopitText => 'assets/images/shopit text.svg';

  /// File path: assets/images/shopit.png
  AssetGenImage get shopit => const AssetGenImage('assets/images/shopit.png');

  /// List of all assets
  List<dynamic> get values => [
        applepay,
        bg,
        emptyCart,
        facebook,
        food,
        google,
        gpay,
        greentick,
        iconPng,
        iconSvg,
        image,
        logoNormal,
        logoRond,
        logoWhite,
        navicon,
        noOrders,
        orderDone,
        shopitText,
        shopit
      ];
}

class Assets {
  Assets._();

  static const $AssetsCategoriesGen categories = $AssetsCategoriesGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
