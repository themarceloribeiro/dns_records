class BasePresenter
  attr_accessor :model, :has_errors, :error_message

  def initialize(options = {})
    options.map { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
  end

  def to_h
    { id: model.id }
  end

  def respond_to_missing?(_method, *_args)
    model.present?
  end

  def method_missing(method, *args, &block)
    super unless model.respond_to?(method)
    model.send(method, *args, &block)
  end
end
