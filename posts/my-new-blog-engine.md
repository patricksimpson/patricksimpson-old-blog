---
title: My Static Markdown Blog Engine
date: November 3, 2014 @ 10:12
synopsis: The a-typical hello world post.
---

I started out on a journey, building a static blog engine, from the ground up. I know it’s been done before and we shouldn’t be reinventing the wheel. But this idea has been bugging me for a long time, it was finally time to get it done. With other engines, I always felt like I give up a little control. I give up a tiny detail that nags me. I can’t stand that one little thing I have to give up. I die a little inside, each time it rears it’s ugly tiny head.

[Ghost](http://tryghost.org) was my last hope. I love Ghost’s editor interface. It’s low barrier to entry was what won me over. But, I lost some control. It didn’t give me everything I wanted. I felt like modifying it outside of what Ghost was providing was difficult or out of reach sort-of-speak. Not to mention (until recently), you’d lose your post if the browser crashed and you forgot to “save a draft”.


## Harp

So I stumbled upon [Harp.js](http://harpjs.com) about 2 weeks ago. I was amazed at how simple and easy it wrapped up features that I wanted. Especially one command to create the static version. This was what I’ve wanted all along. Something simple and a joy to use.

But, it failed me as a complete solution. Not enough features. Creating and maintaining a static blog proved to be a lot of maintenance. (More than I wanted to do). That’s where Ghost won, and I didn’t want give up on that dream. Barrier to entry was one of my biggest concerns afterall.

## Gulp

I’ve created a [Gulp](http://gulpjs.com/) wrapper with [BrowserSync](http://www.browsersync.io/) to my Harp.js site. Now I create blog posts with insane speeds, and still have my static site that I always wanted. Not to mention, I feel like I have 100% control over everything. Content, markup, markdown, etc.. Also, since all my posts are on github, my editor can also be github.com.

Did I do too much? Maybe so. I spent a couple of weekends and nights working on this project. I wanted it to be easy to use for me as well as for anyone else.  Also, I enjoyed the process and learned something.