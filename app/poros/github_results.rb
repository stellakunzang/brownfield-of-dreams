class GithubResults
  def repos
    body = GithubService.new.repos_body
    body.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def repos_limit(number)
    repos[0..number - 1]
  end
end