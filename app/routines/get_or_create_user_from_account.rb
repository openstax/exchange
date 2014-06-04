class GetOrCreateUserFromAccount
  lev_routine

  uses_routine CreateUser,
               translations: { outputs: {type: :verbatim} }

protected

  def exec(account, options={})
    return outputs[:user] = AnonymousUser.instance if account.is_anonymous?

    existing_user = User.where(openstax_accounts_account_id: account.id).first
    return outputs[:user] = existing_user if existing_user.present?

    run(CreateUser, account)
  end
end