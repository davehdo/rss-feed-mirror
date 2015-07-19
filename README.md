# Feed Mirror
## Introduction
Sometimes you wish to broadcast a feed but its behind a firewall. This app lets you POST snapshots of a feed (XML, json, etc) to an external site. The user can request the data in any format. Run two instances of this app, one behind the firewall and one outside.

## Behind the firewall

## Broadcasting
```
POST https://rss-feed-mirror-davehdo.c9.io/snapshots
```
with parameters

- key=[SECRET_KEY]
- feed_name=staff_events
- format=XML or JSON
- body=[BODY]

## Getting the list of feed names
GET https://rss-feed-mirror-davehdo.c9.io/snapshots
with parameters

- key=[SECRET_KEY]
Subscribing to a feed
GET https://rss-feed-mirror-davehdo.c9.io/snapshots/staff_events
with no parameters