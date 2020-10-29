# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to user_photos_path if logged_in?

    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(params.required(:login_form).permit(:username, :password))
    return render :new unless @form.valid?

    user = User.find_by(name: @form.username)
    if user&.authenticate(@form.password)
      login(user)
      redirect_to user_photos_path
    else
      @form.errors.add(:base, 'ユーザーIDまたはパスワードが違います。')
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_user_session_path
  end

  private def login(user)
    reset_session

    session[:user_id] = user.id
  end

  private def logout
    reset_session

    @current_user = nil
  end
end
