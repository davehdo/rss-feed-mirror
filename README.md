# Feed Mirror
## Introduction
Sometimes you wish to broadcast a feed but its behind a firewall. This app lets you POST snapshots of a feed (XML, json, etc) to an external site. The user can request the data in any format. Run two instances of this app, one behind the firewall and one outside.

## Set up a node behind the firewall to send broadcasts
1. Deploy app
2. Create feeds
3. For each feed, choose a post_url e.g. ```http://www.outside_firewall.com/staff_events``` 
4. Set up a scheduled event on your server to fetch feeds and post them

## Set up a node outside firewall to recieve broadcasts
The inside node will request
```
POST http://www.outside_firewall.com/staff_events
```
where 'staff_events' is the feed name and will also contain parameters:

- key=[SECRET_KEY]
- format=XML or JSON
- body=[BODY]

## Getting the list of feed names
```GET http://www.outside_firewall.com```

## Subscribing to a feed
```GET http://www.outside_firewall.com/staff_events```
with no parameters