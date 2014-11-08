---
title: My Static Markdown Blog Engine
date: November 3, 2014 @ 10:12
synopsis: The a-typical hello world post.
---

So I started out on this journey, building a blog engine I actually enjoy. I know it has been done before...
but this idea has been bugging me for a long time, it was finally time. With other engines, I _always_ felt like I give up a little control. I died a little inside.

Ghost was my last hope. I love Ghost's editor interface. It's barrier low barrier to entry was what won me over.
The problem was, I felt like I lost _some_ control. It didn't give me everything I wanted. Yes, I was allowed to quickly create and edit posts, but I felt like modifying it outside
of what Ghost was providing was difficult or out of reach sort-of-speak. Not to mention (until very recently), you'd lose your post if the browser
crashed and you forgot to "save a draft".

## Harp

So I stumbled upon Harp.js about 2 weeks ago. I was amazed at how simple and easy it wrapped up features that I wanted. Especially one command to create the _static_ version. 
 This was what I've wanted all along. Something simple and a joy to use.

Where it failed, *not* enough features: such as browsersync (live reload) and creating a static blog proved to be a lot of maintence. (More than I wanted to do). 
That's where Ghost won, and I didn't want give up on that dream. Barrier to entry was one of my biggest concerns afterall.

## Gulp

I've created a Gulp wrapper (including BrowserSync) to my Harpjs site. Now I create blog posts with insane speeds, and still have my static
site that I always wanted. Not to mention, I feel like I have 100% control over everything. Content, markup, markdown, etc.. Also, since all my posts are on github, my editor is now github.com!

Did I do too much? Maybe so. Yeah, I spent a couple of weekends and nights working on this project. I wanted it to be easy to use for me as well as for anyone else. I enjoyed the process, and I learned something. 

**NOTE**
If you're not into static-site hacking, then I do recommend Ghost to those looking to blog. It was great. It just wasn't for me.
