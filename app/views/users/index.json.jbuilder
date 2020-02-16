json.items do |item|
    json.array! @users, partial: 'users/user', as: :user
end