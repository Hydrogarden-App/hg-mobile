import "package:app_links/app_links.dart";
import "package:clerk_auth/clerk_auth.dart" as clerk;
import "package:flutter/material.dart";

class DeepLinkHandler {
  static const _redirectionScheme = "clerk";
  static const _redirectionHost = "hydrogarden";
  static const _oauthRedirectionPath = "/oauth-redirect";

  static Future<Uri?> _handleDeepLinkForClerk(Uri uri) async {
    if (uri.scheme == _redirectionScheme &&
        uri.host == _redirectionHost &&
        uri.path == _oauthRedirectionPath) {
      return uri;
    }
    return null;
  }

  static Uri? generateDeepLink(BuildContext context, clerk.Strategy strategy) {
    return Uri(
      scheme: _redirectionScheme,
      host: _redirectionHost,
      path: _oauthRedirectionPath,
    );
  }

  static Stream<Uri?> getDeepLinkStream() {
    return AppLinks().allUriLinkStream.asyncMap(_handleDeepLinkForClerk);
  }
}
