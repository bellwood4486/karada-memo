class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_accept_invitation_params, only: :update

  protected

  def invite_params
    # 招待者と同じ家族になるために家族モデルも追加する
    super.merge!(family: current_inviter.family)
  end

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:nickname])
  end

  def after_invite_path_for(inviter, invitee = nil)
    family_path
  end

  def after_accept_path_for(resource)
    family_path
  end
end
