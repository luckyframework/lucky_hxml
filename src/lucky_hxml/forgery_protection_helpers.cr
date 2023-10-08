module LuckyHXML::ForgeryProtectionHelpers
  def csrf_hidden_text_field : Nil
    text_field(
      hide: "true",
      name: Lucky::ProtectFromForgery::PARAM_KEY,
      value: Lucky::ProtectFromForgery.get_token(context)
    )
  end
end
