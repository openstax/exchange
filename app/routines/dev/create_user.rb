module Dev

  class CreateUser
    lev_routine

    uses_routine GetOrCreateUserFromAccount,
                 translations: { outputs: {type: :verbatim} }

  protected

    def exec(options={})
      account = FactoryGirl.create(:openstax_accounts_account,
        options.slice(:first_name, :last_name, :username))

      run(GetOrCreateUserFromAccount, account)
    end
  end

end
