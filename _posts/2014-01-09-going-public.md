---
layout: post
title:  "Going public"
date:   2014-01-10 01:30:50
categories: website design
stylesheet: /css/going-public.css
---


Since apparently every major intelligence agency on the world is watching me,
I figured, why not share my thoughts with other people as well.

This is the first draft of my website. I have been thinking of creating a
website for about two years now, and have created about five different layouts
for it, but never got to the point where I actually created it. Recently many
people and companies started contacting me because of my open source projects
and I realised, once again, that I have already many followers online, but no
actual content to share.


Technology
==========


I had a few goals for this website, that kind of dictated the technologies I
was going to use:

1. I didn't want to be in charge of the hosting of the website. I have hosted
too many websites in my lifetime to know that, sooner or later, it's not fun
anymore.

2. I didn't want any server side language on the website. The few things that
actually require server side computing (newsletter, guestbook, etc...) can easily
be outsourced to other services and be included with JavaScript.

3. I wanted to be able to focus on the writing, and not be distracted by the
design or layout of my articles while writing, or having to modify my article
because it didn't suit my styling visions.

4. *I wanted to have fun doing it!* Having built endless suites that had to be
optimized for IE6+ and other legacy browsers, I really felt the urge to simply
use the latest technology available, and don't look back. If people want to
read my posts on deprecated browsers, they can. But they won't see any layout.

This is why I went with [Jekyll][], [Stylus][], [Dart][] and [Disqus][].



<div class="dark jekyll backdrop">
  <h2>Jekyll</h2>

  <div class="side-by-side">
    <div class="side">
      <img src="/images/posts/logo-jekyll.png" alt="Jekyll logo">
    </div>
    <div class="side">
      <p>
        I think that there's no need to introduce Jekyll, since it's the static site
        generator integrated into GitHub. I have looked at many blogging solutions
        over the year and Jekyll always seemed like the right solution.
      </p>
      <p>
        The fact that GitHub actually has Jekyll support (meaning that you don't
        need to compile your source files before you deploy them) seals the deal.
        GitHub's CDN is very fast and now <a target="_blank" href="https://github.com/blog/1715-faster-more-awesome-github-pages">serves GitHub pages as well</a>.
      </p>
    </div>
  </div>
</div>


Stylus
------

<div class="side-by-side">
  <div class="side">
    <p>
      I started using [styl][] which is the spiritual successor of stylus.
    </p>
    <blockquote><p>
      I actually wanted to use another CSS preprocessor but stylus is just too helpful
    </p></blockquote>
  </div>
  <div class="side"><img src="/images/posts/logo-stylus.png" alt="Stylus logo"></div>
</div>

<div class="side-by-side">
  <div class="side">
{% highlight css %}
main-color = blue
html
  body
    > div
      color main-color
      transition color 1s linear
{% endhighlight %}

    <p>becomes</p>

{% highlight css %}
html body > div {
  color: blue;
  -webkit-transition: color 1s linear;
  -moz-transition: color 1s linear;
  -op-transition: color 1s linear;
  transition: color 1s linear;
}
{% endhighlight %}
  </div>
  <div class="side">
    <p>
      For those of you who don't know what stylus is: It's a CSS preprocessor
      that transforms simplified markup into CSS, taking care of vendor prefixes,
      allowing nested blocks and providing lots of other useful stuff like
      variables, mixins, functions, etc...
    </p>
    <p>
      Other very popular CSS preprocessors are SASS and LessCSS, but I wanted
      to go with <a href="http://www.myth.io/">Myth</a> because I really like
      their «future safe» approach. Unfortunately I am really hooked on nested
      CSS blocks, and they are not part of a CSS draft *yet*. So I had to use
      another preprocessor to combine with Myth, and I finally decided that it's
      not worth the trouble.
    </p>
  </div>
</div>





Dart
----


<div class="side-by-side">
  <div class="side">
    <img class="left" src="/images/posts/logo-dart.png" alt="Dart logo">
  </div>
  <div class="side">
    <p>
      If you haven't been living under a rock, you have probably heard of Dart
      already. It's a new language, developed by Google (and
      [my brother](https://www.dartlang.org/authors/florian-loitsch.html) I might add),
      that has recently
      <a href="http://news.dartlang.org/2013/11/dart-10-stable-sdk-for-structured-web.html">released
      the stable 1.0 SDK</a>.
    </p>

    <blockquote><p>
      The most difficult part was getting the dart editor to play nice with the
      default jekyll file layout.
    </p></blockquote>

  </div>
</div>


Using dart for the simple scripts on this website is really not necessary,
since, at the moment, there aren't more than 30 lines of code, but I wanted to
start using Dart in production and enjoy working with it, so I though: why not?

If you are completely unfamiliar with dart, I highly encourage you to check it
out. While it most definitely is not a huge benefit for small scripts as in this
site, the language really starts to shine the bigger your project gets.



<h1>Thoughts on browsers</h1>


<p>
  This website will only support <a href="http://tomdale.net/2013/05/evergreen-browsers/">evergreen browsers</a>
  (browsers that automatically update themselves). For all other browsers I will
  be serving a pure HTML site without CSS. Why? Because: 
</p>

<blockquote><p>
  I hate old browsers
</p></blockquote>

<p>
  In my line of work I'm constantly excited about new features the web has to offer
  me, and crushed by the sad realisation that I can't use the feature because it
  will exclude 10%-20% of the user base.
</p>

<p>
  For any commercial product, this is relevant. Fortunately, my website is *not*
  commercial. So, I'm sorry if you're surfing like it's the year 2000, but in that
  case you'll have to get by with simple, unformatted HTML.
</p>

<p>Also, I grew up with IE6</p>


[styl]: https://github.com/visionmedia/styl
[jekyll]: http://jekyllrb.com/
[stylus]: http://learnboost.github.io/stylus/
[disqus]: http://disqus.com/
[dart]: https://www.dartlang.org/