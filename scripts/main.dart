
import "dart:html";
import "dart:math";



Element headerElement;
var windowHeight;

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
  
  window.onResize.listen((e) => updateHeaderSize());
  
//  window.onScroll.listen((Event e) => updateHeaderBackground());
  
  updateHeaderSize();
  updateHeaderBackground();
  
  Element h1 = headerElement.querySelector("h1");
  h1.classes.add("relaxed");
  
  
}