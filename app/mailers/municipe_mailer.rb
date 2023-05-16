class MunicipeMailer < ApplicationMailer
  def hello(municipe: nil)
    @municipe = municipe
    mail(to: municipe.email, subject: 'Welcome')
  end
end
