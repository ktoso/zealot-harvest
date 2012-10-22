What is it?
===========
Harvest (http://www.getharvest.com/) is a simple tool to track how much time you've worked and then do the invoice stuff around that.
Sometimes you might want to be more visual about this time worked though - this is where zealot comes in:

<img src="https://raw.github.com/ktoso/zealot-harvest/master/demo.png" alt="zealot demo - i code for aiur"/>

How to install?
===============
1. Get a **heroku** account.
2. `cd` to here
3. `heroku create my-awesome-time-tracker`
4. git push heroku master

You're done installing it! It will be visible under the domain heroku tells you.

How to use?
===========
Simply use http://www.getharvest.com/ like you would always, then deploy Zealot and configure it (copy the `conf.yml.sample` as `conf.yml` and fill in the details).

Deploy to heroku (or wherever you want - as zealot has no dependencies like databases etc), and you're done!

License
=======

I hereby release **Zealot** under the **Beerware** license. A definition of the license can be read up on wikipedia: http://en.wikipedia.org/wiki/Beerware

I've chosen this license as the project is pretty much "anyone can do that", and it's a copy paste hackfest in the views ;-) Having that said, if you want to
use or extend it - pull requests with minor (or major) tweaks would definitely be really awesome :+1:
