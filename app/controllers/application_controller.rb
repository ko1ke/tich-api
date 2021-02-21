class ApplicationController < ActionController::API
  def current_user
    client = FirebaseAuth::Client.new
    client.get_user(uid: uid)
  end

  def current_user?
    !!current_user
  end

  def require_login
    render status: 401, json: { status: 401, message: 'Unauthorized' } unless current_user?
  end

  def uid
    request.headers['uid']
  end
end
