json.extract! user, :username, :email, :created_at

json.followers user.followers.pluck(:username)

json.following user.followed_users.pluck(:username)