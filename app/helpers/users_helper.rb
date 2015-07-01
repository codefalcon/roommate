module UsersHelper
  def show_icon(user)
    img_url = 'https://secure.gravatar.com/avatar/1fda4469bcbec3badf5418269ffc5968'
    image_tag(img_url, alt: user.name, class: "gravatar")
  end

end
