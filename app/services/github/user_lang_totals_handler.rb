class Github::UserLangTotalsHandler

  def initialize(user, user_langs)
    @user = user
    @user_languages = user_langs
    @total_bytes_for_all_languages = 0
  end

  def call
    check_or_create_user_github_lang_totals if @user_languages

    @user.repositories.each do |repo|
      repo.languages.each do |lang|
        user_totals = @user.github_lang_totals.find_by(language: lang)
        bytes = repo.github_lang_totals.find_by(language: lang).bytes

        @total_bytes_for_all_languages += bytes

        user_totals.update(
          repos_count: user_totals.repos_count + 1,
          bytes: user_totals.bytes + bytes
        )
      end
    end

    calculate_and_update_language_percent
  end


  private

  def check_or_create_user_github_lang_totals
    @user_languages.each do |lang_name|
      lang = Language.find_by(name: lang_name.to_s)
      @user.github_lang_totals.find_or_create_by(language: lang)
    end
  end

  def calculate_and_update_language_percent
    @user.github_lang_totals.each do |total|
      total.update(percent: 100.00 / @total_bytes_for_all_languages * total.bytes)
    end
  end
end
