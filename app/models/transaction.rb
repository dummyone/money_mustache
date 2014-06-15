class Transaction < Hashie::Mash
  extend NetworkApi

  def self.all(id)
    data = fetch_all("users/#{id}/transactions")
    data.map do |hash|
      self.new(hash)
    end.sort_by { |transaction| Time.parse(transaction.posted_at).to_i }
  end
end
