How to install?
===============
1. Get a **heroku** account.
2. `cd` to here
3. `heroku create my-awesome-time-tracker`
4. git push heroku master

You're done installing it! It will be visible under the domain heroku tells you.

How to use?
===========
Check how many minutes are added for each tick, and configure cron to run the `i_am_working` script each time it should.

Edit your crontab:

```
crontab -e
```

To contain such an example script (you may tweak it of course):

```
MAILTO=""
*/5 * * * * /home/ktoso/coding/sinatra/zealot/i_am_working > /dev/null
```

The empty MAILTO variable serves to disable email notications from cron about this task, as they're really not interesting most of the time (and you would get an email every 5 minutes...).

License
=======

I hereby release **Zealot** under the **<a href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache License 2.0</a>**

```
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```
