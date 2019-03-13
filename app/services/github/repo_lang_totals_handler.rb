class Github::RepoLangTotalsHandler
  def initialize(repo, repo_langs)
    @repo = repo
    @repo_langs = repo_langs
  end

  def call
    @repo_langs.each do |lang_name, bytes|
      lang = Language.find_or_create_by(name: lang_name.to_s)
      @repo.github_lang_totals.update_or_create_by(lang, repo_lang_data(bytes))
    end
  end


  private
  def repo_lang_data(bytes)
    {
      repos_count: 1,
      bytes: bytes,
      percent: 100.00 / @repo.total_bytes * bytes
    }
  end
end
