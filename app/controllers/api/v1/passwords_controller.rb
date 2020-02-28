class Api::V1::PasswordsController < ApplicationController
  skip_before_action :authorized
  before_action :validate_email_update,  only: :email_send_token

  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by(email: params[:email].downcase)

    if user.present?
      user.generate_password_token!
      PasswordMailer.reset_password(user.reset_password_token, user).deliver_now
      render json: {status: 'ok'}, status: :ok
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end

  def check
    @user = User.find(params[:userId])
    if @user.authenticate(params[:current_password])
      render json: {message: 'good'}
    else
      render json: {message: 'wrong'}
    end
  end

  def reset_password

    userId = params[:userId].to_s

    user = User.find(params[:userId])

    user.update(password: params[:password])
  end

  def email_send_token
      if current_user.update_new_email!(@new_email)
        current_user.generate_email_token!
        render json: { message: "Activation code has been sent to #{current_user.unconfirmed_email}." }, status: :ok
        PasswordMailer.reset_email(current_user.reset_email_token, current_user).deliver_now

      else
        render json: { errors: current_user.errors.values.flatten.compact }, status: :bad_request
      end
  end

  def email_update
    token = params[:token].to_s
    user = User.find_by(reset_email_token: token)

    if !user
      render json: {error: 'The email activiation code seems to be invalid / expired. Try requesting for a new one.'}, status: :not_found
    else
      user.update(email: user.unconfirmed_email)
      render json: {message: 'Email updated successfully'}, status: :ok
    end
  end

  def reset

    token = params[:token].to_s

    if params[:email].blank?
      return render json: {error: 'Token not present'}
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'ok'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end

  def update
    if !params[:password].present?
      render json: {error: 'Password not present'}, status: :unprocessable_entity
      return
    end

    if current_user.reset_password(params[:password])
      render json: {status: 'ok'}, status: :ok
    else
      render json: {errors: current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
    def validate_email_update
      @new_email = params[:email].to_s.downcase

      if @new_email.blank?
        return render json: { status: 'Email cannot be blank' }, status: :bad_request
      end

      if  @new_email == current_user.email
        return render json: { status: 'Current Email and New email cannot be the same' }, status: :bad_request
      end

      if User.email_used?(@new_email)
        return render json: { error: 'Email is already in use. Please select another valid email'}, status: :unprocessable_entity
      end
    end
end
