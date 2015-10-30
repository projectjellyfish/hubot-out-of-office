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
user1>> hubot I'm ooo
hubot>> @user is out of office
```
