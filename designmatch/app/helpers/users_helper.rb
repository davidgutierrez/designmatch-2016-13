module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
    def post_path(post, options={})
    post_url(post, options.merge(:only_path => true))
  end

  def post_url(post, options={})
    url_for(options.merge(:controller => 'posts', :action => 'show',
                          :id => post.id, :slug => post.slug))
  end
end