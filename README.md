# README

Goodnight is a simply CRUD application for managing a user's sleep.
Run the server with `bin/rails server`.

While I've added a basic implementation, there could some bugs and inaccuracy. For clarity, I've provided my intention behind the implementation.
1. Clock In operation, and return all clocked-in times, ordered by created time.

I introduced a table to manage sleep_records.

For clocking in, the field `sleep_time` is used.
For clocking out, the field `wake_time` is used.

`POST /users/:user_id/sleep_records` creates a new sleep record. Use this to clock-in.
`PUT /users/:user_id/sleep_records/:id` updates an existing sleep record. Use this to clock-out.

2. Users can follow and unfollow other users.

I introduced a table to manage relationships, using the terms `follower` and `followee`. 

`POST /users/:user_id/user_follows` allows a user to follow.
`DELETE /users/:user_id/user_follows/:id` allows a user to unfollow.

3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

Note that I've assumed "friends" means someone that you follow. 

`GET /users/:user_id/user_follows/sleep_records` will return the list of sleep_records ordered by sleep duration in descending order.

It could be better to update the endpoint and retrieve particular attributes of a user's followers if we care about extensibility e.g. 

`GET /users/:user_id/user_follows?value="sleep_records"`

Some useful curl commands
```bash
# Create a user
curl -X POST -H "Content-Type: application/json" -d '{"name": "Bob"}' http://localhost:3000/users
# Get the user info
curl -H "Content-Type: application/json" http://localhost:3000/users/1

# Create a sleep record
curl -X POST -H "Content-Type: application/json" -d '{"sleep_time": "2023-01-01T00:00:00Z"}' http://localhost:3000/users/1/sleep_records

# Update a sleep record wake time
curl -X PUT -H "Content-Type: application/json" -d '{"wake_time": "2023-01-02T00:00:00Z"}' http://localhost:3000/users/1/sleep_records/1

# Get the user sleep records
curl -H "Content-Type: application/json" http://localhost:3000/users/1/sleep_records

# User 1 follows user 2 
curl -X POST -H "Content-Type: application/json" -d '{"followee_id": 2}' http://localhost:3000/users/1/user_follows

# User 1 unfollows user 2
curl -X DELETE -H "Content-Type: application/json" -d '{"followee_id": 2}' http://localhost:3000/users/1/user_follows

# User 1 followers
curl -H "Content-Type: application/json" http://localhost:3000/users/1/followers

# User 1 followees (People User 1 follows)
curl -H "Content-Type: application/json" http://localhost:3000/users/1/followees

# Sleep Records of the users following user 1
curl -H "Content-Type: application/json" http://localhost:3000/users/1/user_follows/sleep_records

```
