class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def ban
    render text: "Hello Pandas!"
  end
  
  def emailin
    if settings.production?
      mailin_user = ENV['MAILINUSER']
      mailin_pass = ENV['MAILINPASS']

      Mail.defaults do
      retriever_method :pop3, :address    => "pop.zoho.com",
                              :port       => 995,
                              :user_name  => mailin_user,
                              :password   => mailin_pass,
                              :enable_ssl => true
      end

      email_reply = Mail.first

      if Mail.all.any?
        to_gorp = email_reply.subject
        to_gorp[0..4] = ""

        sms_create(email_reply.body.decoded, to_gorp)

        Mail.delete_all
      end
    end
  end
end
