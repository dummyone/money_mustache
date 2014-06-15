module NetworkApi
  def get(path)
    JSON.parse(RestClient.get(api(path)))
  end

  def fetch_all(path)
    key = path.split('/').last

    result = JSON.parse(RestClient.get(api(path)))
    data = result[key]

    total_pages, current_page = result['meta'].values_at('total_pages', 'current_page')

    2.upto(total_pages).each do |page|
      result = JSON.parse(RestClient.get(api(path, page: page)))
      data.concat(result[key])
    end

    data
  end

  def api(path, params={})
    api_key = Rails.application.secrets.geezeo_api_key
    domain = Rails.application.secrets.geezeo_domain
    "https://#{api_key}@#{domain}/api/v2/#{path}?#{params.to_query}"
  end
end
