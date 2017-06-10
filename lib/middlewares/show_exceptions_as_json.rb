module Middlewares
  class ShowExceptionsAsJson
    def call(env)
      exception = env['action_dispatch.exception']
      exception_class_name = exception.class.name
      status = ActionDispatch::ExceptionWrapper.status_code_for_exception exception_class_name
      message = I18n.t exception_class_name.to_sym, default: :default, scope: 'exceptions.messages'
      body = {message: message}
      headers = {'Content-Type' => "application/json; charset=#{ActionDispatch::Response.default_charset}"}
      [status, headers, [body.to_json.to_s]]
    end
  end
end
