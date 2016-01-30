---
layout: post
title:  "FLASH<wbr>LIGHTS"
date:   2000-01-20 14:28:00
stylesheet: /css/flashlights.css
categories: web programming
cover_image: dark-alley
invisible: true
---

I just released my Solo EP «Flashlights» and built a page to promote its first single of the same title. Since the
page itself is a bit more than a collection of links, and interacts with the video playing in the background, I
figured that some might be interested in gaining some insight into the build process.

So first things first: go to [meno.fm/flashlights](http://www.meno.fm/flashlights/) and watch the video to see the
effects in action. Unfortunately it is built to be viewed for Desktop, so if you are on mobile you will only be able
to see the plain video:

<section class="embedded-video"><div><iframe width="700" height="394" src="https://www.youtube.com/embed/sFBFkZYGgcE?rel=0" frameborder="0" allowfullscreen></iframe></div></section>

What you see on the page, is the video playing in the background with the text appearing at the time of the first verse,
with scribbles on top of it, guiding you through the lyrics. Here and there I added small visual effects that make all
lyrics shake or disappear at appropriate times.

If you like the song, you can buy the whole EP on [Google Play](https://play.google.com/store/music/album/Meno_Flashlights?id=Bvkm477idlkjw6joacowb7aa4he),
[Amazon Music](https://www.amazon.com/gp/product/B01AP3ETYO?ie=UTF8&keywords=meno%20flashlights&qid=1454067033&ref_=sr_1_3&s=dmusic&sr=8-3)
or [iTunes](https://itunes.apple.com/at/album/flashlights-ep/id1075875101?l=en) –
or stream it on [Spotify](https://open.spotify.com/album/14y7LCmuPCBAZqrvc6uqkd). `</self-promotion>`

There is nothing incredibly complicated going on there, but a few things weren't that obvious when I created
the page.


<div class="dark the-player backdrop">
  <h2>The player</h2>

  <div class="side-by-side">
    <div class="side">
      <p>
        The goal is to make the video player always take 100% of the browser height and be centered horizontally.
        <br>
        The simplified markup is: <code>&lt;div class="container"&gt;&lt;iframe&gt;&lt;/iframe&gt;&lt;/div&gt;</code>
        – the iframe containing the Youtube video.
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
        I then position the iframe at the top and <code>left: 50%</code>, which means that the left edge of the iframe
        will be at exactly 50% of the browser window. Now all that's needed, is to adjust this position so it's centered,
        which means that I need to move it exactly half of its width to the left: <code>margin-left: calc((-100vh * 1.777) / 2)</code>
      </p>
    </div>
  </div>
  
  <p>
    Sidenote: setting the width and height actively is necessary for Youtube to get the proper dimensions, otherwise
    Youtube automatically scales down the content for the available space and will not allow the video to be wider than
    the actual browser size.
  </p>
</div>


Now that I've got a nice player in the background I just make sure that pointer events aren't forwarded to the
Youtube player (so the Youtube UI dosn't appear when hovering the player) and use the [Youtube Player API](https://developers.google.com/youtube/iframe_api_reference?hl=en#Playback_controls)
to pause the video when the container is clicked and to implement my own timeline & seeking behaviour.


# The scribbles

  <div class="side-by-side">
    <div class="side">
      <p>
        There are two problems to solve regarding the scribbles:<br>
        1) position them properly and 2) make them appear at the right time.
        </ol>
      </p>
      <p>
        <img style="margin: 0 auto;" src="/images/posts/flashlights-example.jpg">
      </p>
    </div>
    <div class="side">
      <p>
        Lorem blabla
      </p>
    </div>
  </div>