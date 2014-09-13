---
layout: post
title:  "Stop writing stateful HTML"
date:   2000-01-01 14:40:00
categories: web programming
cover_image: rock
invisible: true
---

A lot has changed in the fifteen years that I have been developing websites. The biggest changes happened in the browser, completely restructuring how normal web services behave. Now everybody expects your website to have at least a few dynamic elements on your website. Be it your login form, your shopping cart or a contact form.

> Due to the fact that [JavaScript's browser monopoly is hopefully coming to and end](https://www.dartlang.org) very soon, I will refer to scripts running in the browser as BrowserScript.

# Status Quo

Some websites are actually web apps, which mean that they can be developed completely differently than previously and be written as browser apps that only communicate with the server to get the dynamic data. In this case, the web server is only in charge of serving the app itself and exposing some API (mostly a JSON API) the app can consume. Webmail services, task trackers, calendars etc… are good examples of this. *They are not what this post is about*.


## Typical Websites

Most websites can’t and shouldn’t be built like web apps though, since they need to be crawlable by search engines and they want to be displayed as fast as possible instead of requiring the user to first download the app, that can be a few megabytes.

This is why the approach for normal websites is typically to use a web server to generate HTML sites and provide all the dynamic functionality with HTML. You would then have a normal HTML login form, which posts the data to the server, menus that are rendered differently on the server, depending on if the user is logged in or not, displaying session info, etc…

In a second step the website is “modernised” by adding browser scripts to give the website a snappier feel. The login form gets replaced so the user sees a nice spinner when logging, some items are replaced to be loaded right in the browser to avoid having to reload the whole page and so on.


This approach is typically used because it creates crawlable pages that can even be used by browsers that don’t have JavaScript enabled or are too outdated to properly execute your JavaScript.

There are multiple things that are problematic with this approach though:

- You suddenly have to maintain two code bases: the HTML only variant, and the browser script on top of it
- There’s a lot more overall complexity since your browser script needs to interact properly with your HTML version (if the HTML changes, the browser script might break)
- In most cases the cool browser script variants will never make it, because there is already a working HTML implementation, and there are more important things to do than providing a cooler version of an already existing feature

So in order to also have an HTML only version, you actually create a worse website for 98% of your users to accommodate 2%.

This is where my concept of stateless HTML comes into play.

# How does it work?

The first thing to do, is to think of which things need to be crawlable by search engines. In the case of a recipe website, your “About” page and the single recipe pages would be a good example of pages that need to be discoverable when people search for them on a search engine.

The user menu (`login`, `my account`, `my recipes`, etc…), recipes that might suit the users taste, a contact form and everything that is user specific and dynamic are examples of content that does not need to be included in your HTML.
Instead of generating HTML for it, build this functionality on top of your other HTML pages, fully with browser script. 










The long lasting struggle with slow browser adoption and stale browsers (notably IE6) is also a thing of the past, allowing developers to actually use modern features without 
