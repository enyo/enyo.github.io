library colorglare.header;

/// This library takes care of adjusting the size of the
/// header to always be of the full width and height of
/// the browser, sets the `header-loaded` class on the
/// body element.

import "dart:html";
import "dart:math";
import "dart:async";

Element headerElement;
Element linksElement;
Element loadingElement;
var windowHeight;

/**
 * Initializes the header with the background image.
 */
initHeader() {
  headerElement = document.querySelector("body > header");
  linksElement = headerElement.querySelector(".links");
  loadingElement = linksElement.querySelector(".loading");

  _wrapHeaderLetters();

  // Extracting the image url from the `data-image` attribute.
  var backgroundImage = headerElement.dataset['image'];

  // To prevent showing the spinner when it's actually already loaded
  var loadingTimer = new Timer(new Duration(milliseconds: 200), () {
    document.body.classes.add("loading-header");

    // Force redrawing due to Chrome bug.
    loadingElement.append(new SpanElement());
  });

  _preloadImage(backgroundImage).then((e) {
    loadingTimer.cancel();

    document.body.classes
      ..add("header-loaded")
      ..remove("loading-header");

    _initializeHeaderWithImage(backgroundImage);
  });

  window.onResize.listen((e) => _updateHeaderSize());

  _updateHeaderSize();

  // Decided agains opacity changes.
  // window.onScroll.listen((Event e) => _updateHeaderBackgroundOpacity());
  // _updateHeaderBackgroundOpacity();
}

/**
 * Wraps all letters in the header in <span> elements.
 */
_wrapHeaderLetters() {
  var linkElement = headerElement.querySelector("h1 a");
  var letters = linkElement.text.split("");

  letters = letters.map((letter) => "${letter == "G" ? "<br/>" : ""}<span>$letter</span>").join();

  linkElement.innerHtml = letters;
}

/**
 * Preloads the image.
 */
Future _preloadImage(String imageUrl) {
  var image = new ImageElement();

  image.src = imageUrl;
  return image.onLoad.first; //.then((_) => new Future.delayed(new Duration(milliseconds: 2000)));
}

/**
 * Sets the header background image and the appropriate classes.
 */
_initializeHeaderWithImage(String backgroundImage) {
  headerElement.style.backgroundImage = "url(${backgroundImage})";
}

/**
 * Updates the header element to be the same size as the whole window.
 */
_updateHeaderSize() {
  windowHeight = document.body.getBoundingClientRect().height;
  headerElement.style.height = "${max(windowHeight, linksElement.getBoundingClientRect().height)}px";
}

/// Was meant to fade out the background image when scrolling.
///
/// I decided that I didn't want this though.
_updateHeaderBackgroundOpacity() {
  var ratio = min(window.scrollY / windowHeight, 1);
  headerElement.style.opacity = "${1 - ratio}";
}
