/**
 * This library takes care of adjusting the size of the
 * header to always be of the full width and height of
 * the browser, sets the `header-loaded` class on the
 * body element. 
 */
library header;


import "dart:html";
import "dart:math";
import "dart:async";



Element headerElement;
Element linksElement;
var windowHeight;





/**
 * Initializes the header with the background image.
 */
initHeader() {

  headerElement = document.querySelector("body > header");
  linksElement = headerElement.querySelector(".links");

  _wrapHeaderLetters();
  
  // Extracting the image url from the `data-image` attribute.
  var backgroundImage = headerElement.dataset['image'];
  
  
  _preloadImage(backgroundImage).then((e) {
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
  return image.onLoad.first;
}


/**
 * Sets the header background image and the appropriate classes.
 */
_initializeHeaderWithImage(String backgroundImage) {
  headerElement.style.backgroundImage = "url(${backgroundImage})";
  document.body.classes.add("header-loaded");
}

/**
 * Updates the header element to be the same size as the whole window.
 */
_updateHeaderSize() {
  windowHeight = document.body.getBoundingClientRect().height;
  headerElement.style.height = "${max(windowHeight, linksElement.getBoundingClientRect().height)}px";
}


/**
 * Was meant to fade out the background image when scrolling.
 * 
 * I decided that I didn't want this though.
 */
_updateHeaderBackgroundOpacity() {
  var ratio = min(window.scrollY / windowHeight, 1);
  headerElement.style.opacity = "${1 - ratio}";
}

  