class FreezingEmail::Mail
  attr_accessor :subject, :body, :from, :to, :generated_in

  def initialize(params)
    @subject = params[:subject] if params.has_key?(:subject)
    @body = params[:body] if params.has_key?(:body)
    @from = params[:from] if params.has_key?(:from)
    @to = params[:to] if params.has_key?(:to)
    @generated_in = params[:generated_in] if params.has_key?(:generated_in)
  end
end
