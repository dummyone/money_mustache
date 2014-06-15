class User < Hashie::Mash
  extend NetworkApi

  def self.all
    data = fetch_all('users')
    data.map do |hash|
      self.new(hash)
    end.keep_if(&:id)
  end

  def self.find(id)
    data = get("users/#{id}")
    self.new(data['users'].first)
  end
end
