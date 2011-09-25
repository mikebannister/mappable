Rails.application.routes.draw do
  mount Mappable::Engine => "/map"
  
  match "/" => redirect("/map")
end
