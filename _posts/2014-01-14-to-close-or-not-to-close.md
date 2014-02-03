---
layout: post
title:  "To close or not to close"
date:   2014-02-03 07:40:00
categories: web programming
---


Have you ever wondered if it's better to "close" a `br` or `input` tag like
`<br />` or if it's better to just write `<br>` in HTML5? Or why it's not correct
to write `<script src="script.js" />`? Well so have I, and
my findings on the subject where a lot more interesting than I anticipated
(if for some strange reason you find stuff like this interesting).

If you are not interested in the whole story, just jump to the section «validity»
to get your answer.


# Void elements


Void elements are a special kind of element that **must not** have content.
That's a big difference to other elements that *can* be empty but can also contain
other elements and text (such as `<div>`s).



The most known void elements are:

`<br>` `<hr>` `<img>` `<input>` `<link>` `<meta>`

The lesser known are:

`<area>` `<base>` `<col>` `<command>` `<embed>` `<keygen>` `<param>` `<source>` `<track>` `<wbr>`

That's it. Those are **all** of the existing void elements.


It is not, and has never been, valid HTML to write `<br></br>`, since this would
imply that the `br` element accepts content (writing `<br>Hello!</br>` has 
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

As a side note, elements that do not contain any text, can be written as `<quote//`
which is called [SHORTTAG NETENABL IMMEDNET](http://en.wikipedia.org/wiki/Standard_Generalized_Markup_Language#Other_features)
and is the same as `<quote></quote>`.

Now, by that logic, if a void element does *not* have a closing tag, `<br/` would
be interpreted as `<br>`, and `<br/>` would be interpreted as `<br>>` which is
obviously incorrect syntax. If you're like me, you're probably thinking «This
is insane!». Unfortunately the authors of the HTML4 specification didn't think
so, which is why this is part of the specification. Apparently, the browser
vendors at the time weren't not convinced as well, which resulted in very poor
browser support (which, in this case, is arguably not a bad thing).

XML (and thus XHTML) recognized the madness of such a syntax, and did not include
the *NET* or the *SHORTTAG NETENABL IMMEDNET* «features», but provided a sane
syntax for void elements, namely the [Empty-Element tags](http://www.w3.org/TR/xml/#sec-starttags)
which looks like this: `<br />`, which of course looks very natural which is why
most developers thought it was the right way to write it.


Luckily HTML evolves and the people at the [World Wide Web Consortiumm](http://www.w3.org)
(who are drafting and setting the standards throughout the web) are learning
from their past mistakes as well. Which is why HTML5 makes *a lot* more sense.

Right in the [introduction of the new HTML5 syntax](http://www.w3.org/TR/2009/WD-html5-diff-20090423/#syntax),
the W3C says:

> HTML 5 defines an HTML syntax that is compatible with HTML 4 and XHTML 1
> documents published on the Web, but is not compatible with the more esoteric
> SGML features of HTML 4, such as the NET syntax (i.e. <em/content/).


Yay for HTML5! 

(I think they should have kept the cool *SHORTTAG* feature (`<strong>Hell yea</>`)
but hey... at least HTML is not a complete mess any more)



# Validity

So back to the question of validity, the current [HTML5 specification for void elements](http://www.w3.org/TR/html-markup/syntax.html#void-element)
is as follows:

Start tags consist of the following parts, in exactly the following order:  

- A "<" character.  
- The element’s tag name.  
- Optionally, one or more attributes, each of which must be preceded by one or more space characters.  
- Optionally, one or more space characters.  
- Optionally, a "/" character, which may be present only if the element is a void element.  
- A ">" character.  

This means that the `/` character has been rendered *optional* in HTML5, but
it doesn't add any meaning. There is *absolutely no difference* between `<br>`
and `<br />`.


# Correctness

Well, for those of you who are really addicted to X(HT)ML, you might think, «yeah,
it's optional, but `<br />` is still 'more correct'», but I have to tell you:
it is not. Actually, one might argue that adding `/` to a void tag is an *ignored
syntax error*. The possibility to write it has mostly been added for compatibility
reasons and every browser and parser should not handle `<br>` and `<br />` any
differently.

[Google's styleguide](http://google-styleguide.googlecode.com/svn/trunk/htmlcssguide.xml?showone=Document_Type#Document_Type)
on that subject is also very clear that you should indeed *not* close void tags.


# Theoretical disadvantages

Of course, not closing void tags has it's disadvantages as well, but I think
that they do not outweigh the advantage of having clean and terse void tags like `<meta>`.

The first disadvantage of not closing void tags is that users have to have knowledge
of the existing void tags. If, for example, you don't know what a `<img>` element
is, you might be confused if you can't find any closing tags for it. But the list
of void tags is very short and normally it's quite obvious which tags are void tags.

The second disadvantage is that it gets more complicated for editors to get it
right. They need to have a knowledge of void tags and a complete list to provide
proper highlighting and code completion. If you write `<input>` in an editor,
it *has to know* that there will never be a `</input>` following that.

But it's very easy to implement, and I don't know any browser that doesn't get
this right, so it's not a real disadvantage.


# My opinion on void tags

I think that the whole concept of void tags could be avoided completely by using
the content of some tags instead of defining additional attributes. Let's take
the `<img>` tag for example. It has a *mandatory* `alt` attribute, and for good
reason: people who can't see the image (either because they are physically
incapable or because their device can't display images) should at least now
what image they could see there (and if you're adding an `img` tag solely for
design purposes then you're doing something wrong anyway). So my question is:
why isn't the *content* of the image tag the alternative tag? It seems rather
obvious to me to write `<img src="doge.png">Image of doge</img>`. The same goes
for `<meta>` tags which even have a `content` *attribute*! Why not just use the
actual element content for that? `<input value="Value content">` should be
`<input>Value content </input>` as is the case with `<textarea>`, etc...


So really there are only a few void tags that should exist anyway, but obviously
the W3C has to take backwards compatibility into account which makes changes of
this kind much more difficult.


# Final thoughts: the `<script>` tag

The script tag has really been bothering me because it is such a verbose tag for
such a simple directive. It seems wrong to write `<script src="my-script.js"></script>`
since the content of this `script` tag has no logical correlation to `my-script.js`.

The problem is, that `<script>` is **not** a void tag since you can inline JavaScript
on your page and there are no "optional void tags".

Using the `<link>` tag would have been perfect since it's already used for other
imports and provides all the attributes necessary to include external
files. Of course, as so often in the web, the reason it is not used is backwards
compatibility, since you would exclude all old browsers that don't support that
syntax.





[XML]: http://en.wikipedia.org/wiki/XML
[HTML]: http://en.wikipedia.org/wiki/HTML
[XHTML]: http://en.wikipedia.org/wiki/XHTML