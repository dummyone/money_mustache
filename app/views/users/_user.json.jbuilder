json.extract! user, :login
json.id user.id
json.avatar_url avatar_url(user.email, s: 24)
