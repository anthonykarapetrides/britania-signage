if Rails.env.production?
  BritaniaSignage::Application.config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[Britania Signage Production] ",
      :sender_address => %{"notifier" <do-not-reply@britaniaschool.com>},
      :exception_recipients => %w{anthony.karapetrides@gmail.com}
    }
end
