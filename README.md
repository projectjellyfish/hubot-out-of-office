# hubot-out-of-office

Keeps track of who is working from home, who is out of the office, and who is on holiday

See [`src/out-of-office.coffee`](src/out-of-office.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-out-of-office --save`

Then add **hubot-out-of-office** to your `external-scripts.json`:

```json
[
  "hubot-out-of-office"
]
```

## Sample Interaction

```
user1>> hubot I am out of office
hubot>> @user1 is out of office

user1>> hubot I am back
hubot>> welcome back!

user1>> hubot I am on holiday
hubot>> @user1 on holiday

user1>> hubot I am working from home
hubot>> @user1 working from home

user1>> hubot where is everybody?
hubot>> 
John Smith is on holiday

user1>> hubot I am sick
hubot>> @user1 get well soon!

user1>> hubot where is @wally
hubot>> @user1 Wally Davies should be in...
```
