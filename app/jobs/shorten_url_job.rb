class ShortenUrlJob < ApplicationJob
  queue_as :default

  def perform(user)
    response = make_api_request(user.website_url)
    set_user_short_url(JSON.parse(response.body), user) if response.code == 200
  end

  private

  def make_api_request(url)
    request_url = "https://cutt.ly/api/api.php" \
                  "?key=#{Rails.application.credentials.cuttly_key}" \
                  "&short=#{url}"

    HTTParty.get(request_url)
  end

  def set_user_short_url(json, user)
    if json['url']['status'] == 7
      user.short_url = json['url']['shortLink']
      logger.info "shortened url from #{user.website_url} to #{user.short_url}"
    else
      logger.error "API status #{body['url']['status']}. Failed to shorten URL #{user.website_url}"
    end
  end
end
