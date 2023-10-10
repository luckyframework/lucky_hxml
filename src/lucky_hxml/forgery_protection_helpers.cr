module LuckyHXML::ForgeryProtectionHelpers
  # Defines a hidden text field used for CSRF
  #
  # NOTE: While CSRF is not required for HXML, you can use this if your routes
  # do require a CSRF token
  def csrf_hidden_text_field : Nil
    text_field(
      hide: "true",
      name: Lucky::ProtectFromForgery::PARAM_KEY,
      value: Lucky::ProtectFromForgery.get_token(context)
    )
  end
end
