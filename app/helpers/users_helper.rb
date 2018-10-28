module UsersHelper
  def password_length_hint(minimum_password_length)
    t('users.shared.minimum_password_length', count: @minimum_password_length) if minimum_password_length
  end
end
