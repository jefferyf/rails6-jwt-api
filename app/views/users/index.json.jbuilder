json.items do |item|
    json.array! @users, partial: 'users/user', as: :user
end
json.metadata do
    json.current_page @users.current_page
    json.total_pages @users.total_pages
    json.total_count @users.total_count
    json.actions do
        json.previous path_to_previous_page @users
        json.next path_to_next_page @users
    end
end
