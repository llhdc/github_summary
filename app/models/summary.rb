class Summary < ApplicationRecord
  GITHUB_API_URL="https://api.github.com"

  def user
    user_response
  end

  def repos
    repos_response.sort do |a, b|
      b["pushed_at"].to_date <=> a["pushed_at"].to_date
    end
  end

  def languages
    repos
    .map { |repo| repo["language"] }
    .reject { |lang| lang.blank? }
    .uniq
    .sort
    .join(", ")
  end

  def get_user
    url = "#{GITHUB_API_URL}/users/#{self.username}"
    self.user_response = authenticated_get(url)
  end

  def get_repos
    url = "#{GITHUB_API_URL}/users/#{self.username}/repos"
    response = authenticated_get(url)
    self.repos_response = response.to_a
  end

  def authenticated_get(url)
   token = ENV["GITHUB_PERSONAL_ACCESS_TOKEN"]
   username = ENV["GITHUB_USERNAME"]

     HTTParty.get(
       url,
       headers: {
         "Authorization": "token #{token}",
         "User-Agent": username
       }
     )
   end

end
