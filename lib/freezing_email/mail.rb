class FreezingEmail::Mail
  attr_reader :original_mail, :subject, :body, :from, :to, :generated_in

  def initialize(mail, params)
    @original_mail = mail
    @subject = mail.subject
    @body = mail.body
    @to = mail.to
    @from = mail.from
    @generated_in = params[:generated_in] if params.has_key?(:generated_in)
  end

  def name
    @name ||= "#{@subject.parameterize.tableize}"
  end
end
