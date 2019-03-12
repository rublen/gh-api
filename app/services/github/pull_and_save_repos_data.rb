class Github::PullAndSaveReposData

  def initialize(user)
    @user = user
    @client = Github::Api.new(user_token)
  end

  def call
    @client.repos.each do |repo|
      @user.repositories.update_or_create_by(repo.id, repo_data(repo))
    end
  end


  private

  def user_token
    @user.authorizations.github.first.token
  end

  def repo_data(repo)
    {
      name: repo.name,
      total_bytes: @client.languages(repo).to_h.values.sum,
      description: repo.description,
      language: repo.language,
      stars: repo.stargazers_count,
      forks: repo.forks_count,
      opend_issues: repo.open_issues_count,
      url: repo.html_url,
      license: repo.license&.name
    }
  end
end
