class Github::Api
  attr_reader :client

  def initialize(token)
    @client = Octokit::Client.new(access_token: token)
  end

  def repos
    @repos ||= @client.repos
  end

  def repo_commit_comments(repo)
    @client.list_commit_comments(repo.id)
  end

  def repo_issues(repo)
    @client.list_issues(repo.id)
  end

  def repo_issue_comments(issue)
    @client.issue_comments(issue.repository.id, issue.number)
  end

  def user_events
    @client.user_events(@client.user.id)
  end

  def languages(repo)
    @client.languages(repo.id)
  end
end
