library colorglare.main;

import "dart:html";
import "dart:async";

import "header.dart";
import "side_images.dart";

main() {
  removeHash();
  initHeader();
  initSideImagesUnlessHome();
}

/// Removes the hash from the URL to avoid people sharing it.
removeHash() {
  new Timer(const Duration(milliseconds: 10),
      () => window.history.replaceState({}, document.title, window.location.pathname));
}
