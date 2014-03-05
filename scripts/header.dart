/**
 * All header related functionality is here. 
 */
library header;


import "dart:html";
import "dart:math";
import "dart:async";




/**
 * Wraps all letters in the header in <span> elements.
 */
wrapHeaderLetters() {
  var linkElement = document.querySelector("body > header h1 a");
  var letters = linkElement.text.split("");

  letters = letters.map((letter) => "<span>$letter</span>").join();

  linkElement.innerHtml = letters;
}

