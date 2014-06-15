json.transactions do
  json.array!(@transactions) do |transaction|
    # json.extract! transaction, :posted_at
    json.posted_at Time.parse(transaction.posted_at).to_i
    if transaction.transaction_type == 'Credit'
      json.balance transaction.balance
    else
      json.balance -transaction.balance
    end
  end
end
