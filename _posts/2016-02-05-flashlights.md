---
layout: post
title:  "FLASH<wbr>LIGHTS"
date:   2016-02-05 18:40:00
stylesheet: /css/flashlights.css
categories: web programming music design
cover_image: dark-alley
invisible: true
---

I just released my Solo EP «Flashlights» and built a page to promote its first single of the same title. Since the
page itself is a bit more than a collection of links, and interacts with the video playing in the background, I
figured that it might be of interest to some people to gain insight into the build process.

So first things first: go to [meno.fm/flashlights](http://www.meno.fm/flashlights/) and watch the video to see the
effects in action. Unfortunately it is built to be viewed for Desktop, so if you are on mobile you will only be able
to see the plain video:

<section class="embedded-video">
  <div><iframe width="700" height="394" src="https://www.youtube.com/embed/sFBFkZYGgcE?rel=0" frameborder="0" allowfullscreen></iframe></div>
</section>

What you see on the page, is the video playing in the background with the text appearing at the time of the first verse,
with scribbles on top of it, guiding you through the lyrics. Here and there I added small visual effects that make all
lyrics shake or disappear at appropriate times.

If you like the song, you can buy the whole EP on [Google Play](https://play.google.com/store/music/album/Meno_Flashlights?id=Bvkm477idlkjw6joacowb7aa4he),
[Amazon Music](https://www.amazon.com/gp/product/B01AP3ETYO?ie=UTF8&keywords=meno%20flashlights&qid=1454067033&ref_=sr_1_3&s=dmusic&sr=8-3)
or [iTunes](https://itunes.apple.com/at/album/flashlights-ep/id1075875101?l=en) –
or stream it on [Spotify](https://open.spotify.com/album/14y7LCmuPCBAZqrvc6uqkd):
 
<div>
  <iframe style="display: block; width: 300px; margin: 0 auto;" src="https://embed.spotify.com/?uri=spotify%3Aalbum%3A14y7LCmuPCBAZqrvc6uqkd&theme=white&view=coverart" width="300" height="80" frameborder="0" allowtransparency="true"></iframe>
</div>

`</self-promotion>`


<div class="dark the-player backdrop">
  <h2>The player</h2>

  <div class="side-by-side">
    <div class="side">
      <p>
        The goal was to make the video player always take 100% of the browser height and be centered horizontally.
        <br>
        The simplified markup is: <code>&lt;div class="container"&gt;&lt;iframe&gt;&lt;/iframe&gt;&lt;/div&gt;</code>
        – the iframe containing the YouTube video.
      </p>
      <p>
        The container has the width and height set to <code>100vw</code> and
        <code>100vh</code> respectively (viewport units), to make sure it consumes 100% of the browser space and has
        <code>overflow: hidden</code> so the browser won't introduce scroll bars if the video sticks out.
      </p>
    </div>
    <div class="side">
      <p>
        The iframe is positioned absolutely inside the container with a height of <code>100vh</code> as well.
        To make sure it always has the right dimensions (16:9) I make use of a <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/calc">fairly new CSS function</a>
        to calculate the width: <code>width: calc(100vh * 1.777)</code>.
      </p>
      <p>
        I then positioned the iframe at the top and <code>left: 50%</code>, which means that the left edge of the iframe
        will be at exactly 50% of the browser window. Now all that was needed, was to adjust this position so it's centered,
        which means that I needed to move it exactly half of its width to the left: <code>margin-left: calc((-100vh * 1.777) / 2)</code>
      </p>
    </div>
  </div>
  
  <p>
    Sidenotes: setting the width and height actively is necessary for YouTube to get the proper dimensions, otherwise
    YouTube automatically scales down the content for the available space and will not allow the video to be wider than
    the actual browser size.<br>
    Also, the iframe is actually in a <code>#player</code> div, and the YouTube JavaScript iframe embed method creates the
    iframe and appends it to the DOM. Please refer to the
    <a href="https://developers.google.com/youtube/iframe_api_reference">official YouTube API Reference</a> for more
    information.
  </p>
</div>


Now that I had a nice player in the background I just made sure that pointer events weren't forwarded to the
YouTube player by overlaying an invisible div that captures all those events (so the YouTube UI doesn't appear when
hovering the player) and using the [YouTube Player API](https://developers.google.com/youtube/iframe_api_reference?hl=en#Playback_controls)
to forward any events to pause or resume the video when the container is clicked and to implement my own timeline &
seeking behaviour.


# The scribbles

<p>
  <img style="margin: 0 auto;" src="/images/posts/flashlights-example.jpg">
</p>

There were two problems to solve regarding the scribbles:  
1) make them appear at the right time and
2) position them properly.


## 1) Timing

<p>
  To make them appear at the right time, I made use of YouTubes JavaScript API. In the <code>onStateChange</code>
  event, I checked whether <code>event.data == YT.PlayerState.PLAYING</code> and if so, I started a periodic timer
  with <code>setInterval(updateTime, intervalDelay)</code>, with <code>updateTime</code> being the periodically
  invoked callback, and <code>intervalDelay</code> the time between each interval (I chose 25ms).
</p>

<div class="side-by-side">
  <div class="side">
    <p>
      Inside the <code>updateTime</code> I used the <code>player.getCurrentTime()</code> function to get the time of the video.
      <br>
      Unfortunately, the
      time returned by this function is not very precise (if queried in a 25ms interval, you will get the same time multiple
      times), so I needed to adjust the time accordingly to make sure that the scribbles appear at exactly the time I
      wanted them to. The easiest way to address this issue, was to simply add 25ms to the last time retrieved, as
      long as the time returned by <code>getCurrentTime()</code> is the same.
    </p>
  </div>
  <div class="side">
{% highlight js %}
var intervalDelay = 25; // in ms

// All in seconds
var lastTime = -1, exactTime = 0;

// Called every 25ms
function updateTime() {
  var currentTime = player.getCurrentTime();
  if (currentTime != lastCurrentTime) {
    // The first time, or every time we get a
    // new currentTime
    lastTime = exactTime = currentTime;
  }
  else {
    // Since we got the same time again, but
    // know that we call this function every
    // 25ms, we just add it.
    exactTime += intervalDelay / 1000;
  }
  highlight(exactTime);
}
{% endhighlight %}
  </div>
</div>
   
The mundane part then, was to get all the timings of the scribbles. I did that by loading the video into a video editing
software, and write down all the time codes. I then marked up the individual phrases that I wanted to add scribbles to like
that: `<span data-time="33.92">vultures</span>`. The `highlight()` function checks if one of the phrases should be
highlighted based on that `date-time` attribute, and if so, it adds the `.highlight` class which makes the
scribble appear and then fade out.

## 2) Positioning

But how did I add the scribble, and how are the scribbles positioned? Well... that actually took me some time to get right.
I wanted to find a solution that met all the following criteria:

- I didn't want individual images to be loaded due to http overhead, but one spritemap
- the spritemap should be generated automatically – I didn't want to copy paste images all day
- the scribbles should be perfectly positioned, accounting for different font renderings (so just using one
  big image over the whole paragraph and positioning the scribbles is a no-no)
- I didn't want to fiddle with coordinates and painstakingly write down pixels for each scribble
- This one is basically a summary of the others: I wanted to be able to iterate quickly. So when I wanted to make changes
  to the scribbles, I didn't want to change coordinates in my source code or have a manual process where I need to copy
  some images around.

To solve all those problems, I made following decisions:
 
- Every highlights position is measured from the center of a `<span>` of a single word or phrase. So let's say the word
  «Flashlight» should be highlighted, then my script adds an additional `<span>` inside this word's span,  positioning
  it at the center.
- This allows me to create the scribbles inside Photoshop, by defining a fixed width/height rectangle for each word,
  positioning the individual words I want to highlight at the center of each rectangle, and just draw over it:  
  ![](/images/posts/flashlights-scribble-screenshot.png)  
  In the end, I just save the [scribbles without background or text](https://github.com/enyo/meno.fm/blob/gh-pages/flashlights/images/highlights/_verse1.png)
  as a `png` (so just scribbles with a transparent background).
  This approach ensures minimal displacement, since even very different font rendering will render the word at pretty
  much the same position
- I could already use this image as a CSS spritemap, but this image is obviously _a lot_ larger than needed, and
  contains a lot of unnecessary white space. So I wrote a [script](https://github.com/enyo/meno.fm/blob/gh-pages/flashlights/images/highlights/_production/bin/create_spritemap.dart)
  that goes through each rectangle, trims the white space around each scribble, generates a new
  [optimized spritemap](https://github.com/enyo/meno.fm/blob/gh-pages/flashlights/images/highlights/verse1.png) and
  generates a [json file](https://github.com/enyo/meno.fm/blob/gh-pages/_includes/flashlights/verse1.json) with the
  necessary information to be able to position each scribble at the center again (depending on how much white space has
  been removed on each side).
  You might be thinking that this step is unnecessary, because empty space in a png should be compressed
  properly, but unfortunately, even after png optimization, there is a significant difference in size. It will also take
  much less space in memory in the browser.
- I then use [optipng](http://optipng.sourceforge.net/) on the spritemap to ensure that it is the smallest possible size
- Finally, inside my browser script, I use the generated JSON to properly position all scribbles, with the resulting
  elements looking like this:  
  ![Scribble example](/images/posts/flashlights-scribble-example.png)
  

# Final Words

The whole page is open source, so feel free to go through it if you want more information: [github.com/enyo/meno.fm](https://github.com/enyo/meno.fm)

I hope that this post has been useful to you and that it will help you create something great.
