class FreezingEmail::Mail
  attr_reader :delivery_handler, :subject, :body, :from, :to, :generated_in

  def initialize(mail, params)
    @subject = mail.subject
    @body = mail.body
    @to = mail.to
    @from = mail.from
    @delivery_handler = mail.delivery_handler.to_s
    @generated_in = params[:generated_in] if params.has_key?(:generated_in)
  end

  def name
    @name ||= "#{@subject.parameterize.tableize}"
  end
end
