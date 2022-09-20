class ApplicationController < ActionController::Base
  
  def after_sign_up_path_for(resource)
   case resource
   when Admin
     admin_root_path
   when Public
     public_root_path
   end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin   # ログアウト時はシンボルが返ってくる
      new_admin_session_path
    when :end_user  # ログアウト時はシンボルが返ってくる
      public_root_path
    end
  end  
  
end
