json.id user.id
json.name user.name
json.email user.email
json.actions do |action|
    json.show do
        json.url url_for(user)
        json.method :get
    end
    json.update do 
        json.url url_for(user)
        json.method :put
    end
    json.delete do
        json.url url_for(user)
        json.method :delete
    end
end