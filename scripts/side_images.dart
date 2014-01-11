
/**
 * This library sees if an image in a .side div is visible
 * and adds appropriate classes so CSS can animate them
 */
library side_images;


import "dart:html";


ElementList images;

initSideImagesUnlessHome() {

  // Should only do something on post sites.
  if (document.body.id == "site-home") return;

  images = document.querySelectorAll(".side img");
  
  
  _updateImageClasses();

  window.onScroll.listen((e) => _updateImageClasses());
  
}




num windowHeight;
int scrollTop;


/**
 * Sets the .out-of-view class on all images that are out of view
 */
_updateImageClasses() {
 
  windowHeight = document.body.getBoundingClientRect().height;
  
  scrollTop = document.body.scrollTop;
  
  for (Element image in images) {
    if (_inViewport(image)) {
      image.classes.remove("out-of-view");
    }
    else {
      image.classes.add("out-of-view");
    }
  }
  
}


/**
 * Returns true or false depending on if the image is in the viewport
 */
bool _inViewport(Element image) {

  var top = image.getBoundingClientRect().top + window.pageYOffset + document.documentElement.clientTop;
  var bottom = top + image.getBoundingClientRect().height;
  
  if (bottom > scrollTop && top < scrollTop + windowHeight) {
    return true;
  }
  else {
    return false;
  }
  
}

