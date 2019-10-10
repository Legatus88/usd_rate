# USD Rate

This small app scraps USD rate from ***'www.cbr.ru'*** and shows it on the home page.

Every minute it scraps in again and update in without page refreshing on all opened pages.

It also can find you a rate by different date and don't refresh it for some time.

You can define a period. After the deadline it will continue to refresh it on the home page.

## Usage

This app uses Redis, so you need to run it first.

Or you can just start the ***foreman*** :)

```
foreman start -f Procfile
```
