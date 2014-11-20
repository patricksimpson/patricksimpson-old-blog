---
title: "Intro to Polymer"
description: "Enter the future, of web components"
date: "Thu Nov 20 2014 12:54:36 GMT-0500 (EST)"
---

## What is Polymer?

An opinioned way to embrace the future, web component standards (http://w3c.github.io/webcomponents/explainer/).

https://www.polymer-project.org/

Big frameworks are heading this way: 

 - React.js - http://facebook.github.io/react
 - Ember.js - http://emberjs.com/
 - Angular.js - https://angularjs.org/

## Why use Polymer?

(from hacker news): 

When you ask "should I use Polymer", what I hear is, "should I get a jump start on the upcoming future of the web"? Lets       be clear here, Mozilla, IE, Chrome etc... are all merging on these technologies. 

Object observers, templating, web components etc... are all emerging, Polymer is just one way you can use them now and tie them all together in an opinionated way. 

If you don't like it you don't have to use polymer you could just use plain ol JS and achieve the exact same solution,         just slightly more verbose and with less support.


## Examples

You'll need polymer, run `bower install Polymer/polymer`

Import Elements

    <link rel="import" href="elements/my-name.html">

Why this is awsome:

To me, the real benefit is shared components (http://customelements.io/). For example, Polymer provides (code-ajax) element. 

To use it all I needed to do was run `bower install Polymer/core-ajax`

    <link rel="import" href="../bower_components/polymer/polymer.html">
    <link rel="import" href="../bower_components/core-ajax/core-ajax.html">
    <polymer-element name="my-name" noscript>
      <template>
        <core-ajax url="http://polymer.dev/twitter.json" auto response="{{res}}"></core-ajax>
        <div> Hello, my name is {{res.name}} </div>
      </template>
    </polymer-element>

## Resources

### Polymer

 - https://www.polymer-project.org/
 - https://www.polymer-project.org/docs/polymer/polymer.html

### Web Components

 - http://css-tricks.com/modular-future-web-components/
 - http://webcomponents.org/resources/
 - http://w3c.github.io/webcomponents/spec/custom/
 - http://w3c.github.io/webcomponents/spec/shadow/

### What is Shadow DOM?

 - http://webcomponents.org/articles/introduction-to-shadow-dom/
 - http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/

### Custom Components

 - http://customelements.io/
 
### Advanced

 - Inline all your components: https://github.com/polymer/vulcanize
 - Styling Web Components: https://www.polymer-project.org/articles/styling-elements.html
