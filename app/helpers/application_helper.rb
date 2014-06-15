module ApplicationHelper
  def avatar_url(email, params={s:48})
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?#{params.to_query}&d=retro"
  end
end
