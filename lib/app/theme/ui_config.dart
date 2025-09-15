// common across all views
abstract final class AppPaddings {
  static const gigantic = 46.0;
  static const enormous = 32.0;
  static const huge = 24.0;
  static const large = 16.0;
  static const medium = 12.0;
  static const small = 8.0;
  static const tiny = 4.0;
}

abstract final class BlurConfig {
  static const spread = 1.0;
  static const radius = 5.0;
}

abstract final class CornerRoundingConfig {
  static const medium = 20.0;
}

abstract final class SurfaceSizeConfig {
  static const heightSmall = 40.0;
  static const heightMedium = 90.0;
  static const heightLarge = 150.0;
}

abstract final class IconSizeConfig {
  static const small = 20.0;
  static const medium = 35.0;
  static const large = 55.0;
}

// specific to a view

abstract final class DeviceInfoViewConfig {
  static const onOffSectionPlaceholderHeight = 95.0;
}
