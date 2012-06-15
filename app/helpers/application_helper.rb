module ApplicationHelper

def welcome_text
  str = "" #jika user telah login, tampilkan welcome textnya
  if current_user
    str = "Welcome, #{current_user.email} | "
    str += link_to "home  ", root_url
    str += link_to "products  ", products_path
    str += link_to "article  ", articles_path
    str += link_to "category  ", categories_path
    str += link_to "Logout  ", log_out_path
    
  else
    str = "#{link_to "Login  ", log_in_path} | "
    str += link_to "Signup  ", sign_up_path
    str += link_to "home  ", root_url
    str += link_to "products  ", products_path
    str += link_to "article  ", articles_path
    str += link_to "category  ", categories_path
  end
end 
end
