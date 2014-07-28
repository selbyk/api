json.extract! user, :username, :email, :created_at

json.followers user.followers.each do |follower|
  json.extract follower, :username
end

json.following user.followed_users.each do |u|
  json.extract! u, :username
end