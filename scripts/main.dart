
import "dart:html";
import "dart:math";



Element headerElement;
var windowHeight;


initializeHeader(String backgroundImage) {
  headerElement.style.backgroundImage = "url(${backgroundImage})";
  headerElement.classes.add("image-loaded");
  Element h1 = headerElement.querySelector("h1");
  h1.classes.add("relaxed");
  document.body.classes.add("header-loaded");
}

updateHeaderSize() {
  windowHeight = document.body.getBoundingClientRect().height;
  headerElement.style.height = "${windowHeight}px";
}

updateHeaderBackground() {
  var ratio = min(window.scrollY / windowHeight, 1);
  headerElement.style.opacity = "${1 - ratio}";
//  print(window.scrollY / windowHeight);
}


main() {

  headerElement = document.querySelector("body > header");

  var backgroundImage = headerElement.dataset['image'];

  var image = new ImageElement();

  image.src = backgroundImage;
  image.onLoad.first.then((e) => initializeHeader(backgroundImage));

  window.onResize.listen((e) => updateHeaderSize());

//  window.onScroll.listen((Event e) => updateHeaderBackground());
  updateHeaderSize();
  updateHeaderBackground();


}