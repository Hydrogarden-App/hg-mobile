import "package:flutter/rendering.dart";
import "package:hydrogarden_mobile/app/theme/color_consts.dart";

abstract final class TextConsts {
  static const title = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: ColorConsts.dark,
  );
  static const subtitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: ColorConsts.dark,
  );
  static const normal = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: ColorConsts.dark,
  );
  static const hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: ColorConsts.dark,
  );
}
