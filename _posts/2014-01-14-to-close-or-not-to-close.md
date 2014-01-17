---
layout: post
title:  "To close or not to close"
date:   2014-01-14 01:30:50
categories: web programming
invisible: true
---


Have you ever wondered if it's better to "close" a `br` or `input` tag like
`<br />` or if it's better to just write `<br>` in HTML5? Or why it's not correct
to write `<script src="script.js" />`? Well so have I, and
my findings on that subject were a lot more interesting than anticipated
(if for some strange reason you find stuff like this interesting).




# Void elements


Void elements are a special kind of element that **must not** have content.
That's a big difference to other elements that *can* be empty but can also contain
other elements and text (such as `<div>`s).



The most known void elements are:

`<br>` `<hr>` `<img>` `<input>` `<link>` `<meta>`

The lesser known are:

`<area>` `<base>` `<col>` `<command>` `<embed>` `<keygen>` `<param>` `<source>` `<track>` `<wbr>`

That's it. Those are **all** existing void elements.


It is not, and has never been, valid HTML to write `<br></br>`, since this would
imply that the `br` element accepts content (Writing `<br>Hello!</br>` has 
absolutely no meaning). However, it is very common to see both `<br>` and `<br />`.

Although most people know that in **X**HTML it is *mandatory* to write `<br />` the
rules for HTML are less obvious.


# History

To completely understand the rules of void elements a bit of history is necessary.

[HTML][], [XML][] and [X(HT)ML][XHTML] are all based on [**SGML**](http://en.wikipedia.org/wiki/Standard_Generalized_Markup_Language),
the Standard Generalized Markup Language which has been crafted in 1986.

HTML and XML derived directly from SGML. XML is a more restrictive subset of SGML
and that's what XHTML is based on.

> XHTML is basically the same as HTML but based on XML.

So far so good? Then lets get to the interesting part:

SGML has a feature called [NET (Null End Tag)](http://en.wikipedia.org/wiki/Standard_Generalized_Markup_Language#NET).
This is a short notation to avoid having to close a tag when the content
of your element is simple text. With *NET* you can write `<quote/Quoted text/`
instead of `<quote>Quoted text</quote>`.

Naturally, elements that do not contain any text, can be written as `<quote//`
which is called [SHORTTAG NETENABL IMMEDNET](http://en.wikipedia.org/wiki/Standard_Generalized_Markup_Language#Other_features)
and is the same as `<quote></quote>`.

Now, by that logic, if a void element does *not* have a closing tag, `<br/` would
be interpreted as `<br>`, and `<br/>` would be interpreted as `<br>>` which is
obviously incorrect syntax. If you're like me, you're probably thinking «This
is insane!». Unfortunately the authors of the HTML4 specification didn't think
so, which is why this is part of the specification. Apparently, the browser
vendors at the time weren't not convinced as well, which resulted in very poor
browser support (which is not a bad thing arguably).


  - XML (and thus XHTML) implemented it sanely, namely the **Empty-Element tags**
    http://www.w3.org/TR/xml/#sec-starttags


  So HTML4 was `<foo//` and X(HT)ML was `<foo />`


  - HTML5 spec:

  http://www.w3.org/TR/2009/WD-html5-diff-20090423/#syntax

  > HTML 5 defines an HTML syntax that is compatible with HTML 4 and XHTML 1
  > documents published on the Web, but is not compatible with the more esoteric
  > SGML features of HTML 4, such as the NET syntax (i.e. <em/content/).



Sidenote: I think they should have kept the cool *SHORTTAG* feature: `<strong>Hell yea</>`


Freaky? you betcha. Luckily this all doesn't really matter now.


# Validity


- Is any of the two more valid than the other

- link to spec -> completely optional



# Correctness

Isn't /> still "more correct"

- No, because it is kind of an **ignored syntax error**! At least it has absolutely no meaning.




# Theoretical advantages



User knowledge

  Unexperienced coders must remember the list of void tags. But the list is short
  and normally obvious.

Easier parsing
  - Editors know that they shouldn't propose `</foo>` when the previous element
  was `<foo />`. If it's a void tag, and written `<foo>` the editor **has to know**
  that it's a void tag.
  But: all editors know this.




# My opinion on void tags

I don't see the reason for most void tags.

`<meta name="" content="">` should be `<meta name="">CONTENT</meta>`.

`<img alt="Alternative text" src="">` should be `<img src="">Alternative text</img>`.
The `alt` attribute is mandatory anyway for crying out loud.

`<input value="Content">` should be `<input>Content</input>` as is the case with `<textarea>`

etc... 

So really there are only a few void tags that should exist anyway.

Of course the reason is backwards compatibility



# The `<script>` tag

Since it *can* contain content, it's not a void element, 
I think there should be another tag. It's weird to write `<script src=""></script>`.

`<link>` would have been perfect. Since `<script>` is **not** a void tag, it can
not be closed like `<script></script>`.













Sources
=======


http://stackoverflow.com/questions/69913/why-dont-self-closing-script-tags-work/3327807#3327807


In case anyone's curious, the ultimate reason is that HTML was originally a dialect of SGML, which is XML's weird older brother. In SGML-land, tags can be specified in the DTD as either self-closing (e.g. BR, HR, INPUT), implicitly closeable (e.g. P, LI, TD), or explicitly closeable (e.g. TABLE, DIV, SCRIPT). XML of course has no concept of this.

The tag-soup parsers used by modern browsers evolved out of this legacy, although their parsing model isn't pure SGML anymore. And of course your carefully-crafted XHTML is being treated as badly-written tag-soup/SGML unless you send it with an XML mime type. This is also why...

    <p><div>hello</div></p>

...gets interpreted by the browser as:

    <p></p><div>hello</div>

Stackoverflow:



Not exactly.

In HTML 4, <foo / means <foo> (which leads to <br /> meaning <br>&gt; and <title/hello/ meaning <title>hello</title>). Browsers did a very poor job of supporting this and the spec advises authors to avoid the syntax.

In XHTML, <foo /> means <foo></foo>, but since this only works in XML parsing mode and most documents are served as text/html there are compatibility guidelines to follow.

In HTML 5, <foo /> means <foo>. The slash is just syntactic sugar for people who are addicted to XML. The syntax is valid, but it is not a "self-closing tag". The distinction is important since (in the HTML syntax at least) <div /> means <div> in HTML 5 and not <div></div> as it does in XHTML.






google recommendation: http://google-styleguide.googlecode.com/svn/trunk/htmlcssguide.xml?showone=Document_Type#Document_Type

w3c spec: http://www.w3.org/TR/html-markup/syntax.html#void-element


    Start tags consist of the following parts, in exactly the following order:
    A "<" character.
    The element’s tag name.
    Optionally, one or more attributes, each of which must be preceded by one or more space characters.
    Optionally, one or more space characters.
    Optionally, a "/" character, which may be present only if the element is a void element.
    A ">" character.




[XML]: http://en.wikipedia.org/wiki/XML
[HTML]: http://en.wikipedia.org/wiki/HTML
[XHTML]: http://en.wikipedia.org/wiki/XHTML