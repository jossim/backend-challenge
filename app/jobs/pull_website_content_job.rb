class PullWebsiteContentJob < ApplicationJob
  queue_as :default

  def perform(user)
    html = html_from_url(user.website_url)
    user.website_content = header_text_from_html(html)
  end

  private

  def header_text_from_html(html)
    if html.instance_of? String
      html
    else
      headers_from_html(html).map(&:content).join("\n")
    end
  end

  def headers_from_html(html)
    html.css('h1, h2, h3')
  end

  def html_from_url(url)
    response = HTTParty.get(url)
    Nokogiri::HTML.parse(response.body)
  rescue SocketError => e
    logger.error e.message
    "Request to URL failed"
  end
end
