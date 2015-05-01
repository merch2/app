class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, mail_params)
    resource.update_without_password(mail_params)
  end

  def mail_params
    params[:user].permit(:email)
  end
end