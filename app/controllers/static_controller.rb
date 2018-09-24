
class StaticController < ActionController::Base

  protect_from_forgery with: :null_session

  def check_nickname
    puts "ssss"
    puts params.inspect
    user =User.find_by(nickname: params['nickname'])
     render json: { is_exist: user.present?}

  end

end
