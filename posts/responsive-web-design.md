---
title: "Responsive Web Design"
date: 23 May 12 @ 12:00
description: ""
---

Responsive web design, introduced by Ethan Marcotte, is starting to creep in more and more into the “buzz-words of 2012″ category. I really don’t mind the new attraction to the term;  I just want people to have a better understanding of what the term actually means.


Responsive Web Design (RWD) is a new technique to enhance websites for mobile support. There is a lot to RWD though, its not as simple as it sounds. It takes a complete shift in thinking and design approach to your website. While some “quick fixes” can be applied, it’s just not that simple. You must start from the ground up. Mobile first, then beyond.

For this post though, I want to try to briefly explain RWD and provide some useful links so that you may follow up if you wish. RWD can boiled down into three main concepts: Fluid grid, fluid content, and media queries.

Fluid Grid

So what do I mean by the fluid grid? This technique has been done for years on many different websites. This technique has the design of the website inside a fluid based layout. Meaning the layout will get bigger, as the browser size increases, and get smaller as the browser size gets smaller. This can be achieved using percentages, or em’s in your CSS to be applied to your content blocks.

Fluid Content

This is just ensuring that your content, especially your images, are flexible. Meaning your apply CSS attributes to your images such as:

img { max-width: 100%; }
This allows the image to expand to the maximum width of the containing element. In other words, it won’t overflow and/or break your website design.

Also, take advantage of floats. Floating your content ensures for some flexibility.

Media Queries

This, while only being a slight enhancement, is the reason why RWD is gaining ground. It is a way to target different browser sizes to use different CSS. This can be done simply by using the “media” attribute on your stylesheet links. For example:

 	<link rel="stylesheet" href="stylesheets/450.css" media="only screen and (min-width: 450px)"> 

	<link rel="stylesheet" href="stylesheets/620.css" media="only screen and (min-width: 620px)"> 

	<link rel="stylesheet" href="stylesheets/950.css" media="only screen and (min-width: 950px)"> 
	
So what’s all this mean?

Each one of theses links to the style sheets will only apply if the “min-width” of the browser is met. That means you can change your layout, by using different styles, based on the current size of the browser.

Now, with this, you may need to consider designing from the smallest to the largest. It would be much easier to add, than to remove from your design.

You start by designing for a small screen size, such as 320 pixels, and work your way up. Add queries when your website breaks. Don’t target specific native widths for devices! That would lead to having a different style sheet for every device… at the rate they are being made, you will have a lot of updating to do. Instead, focus on what looks good with your design. Drag your browser window larger and smaller to see how it scales. Fix it where it breaks, that way it will scale to any screen size.

I hope this helps.

Links:

http://www.abookapart.com/products/responsive-web-design
http://ethanmarcotte.com/
http://www.alistapart.com/articles/fluidgrids/
http://unstoppablerobotninja.com/entry/fluid-images
A special thanks to: http://buildresponsively.com/