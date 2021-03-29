class User::Signup < User
  after_create :shorten_url, :set_website_content

  private

  def shorten_url
    ShortenUrlJob.perform_later self
  end

  def set_website_content
    PullWebsiteContentJob.perform_later self
  end
end
