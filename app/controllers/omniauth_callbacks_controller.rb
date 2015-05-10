class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  def twitter
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      render partial: 'omni/form', object: request.env['omniauth.auth'], as: 'auth'
    end
  end

  def complete_auth
    @user = User.find_for_oauth(OmniAuth::AuthHash.new(params[:auth]))
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      flash[:notice] = 'Plz fill email!'
      render partial: 'omni/form', object: OmniAuth::AuthHash.new(params[:auth]), as: 'auth'
    end
  end

end