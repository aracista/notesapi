class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
    #REGISTER
    def create
        @user = User.create(user_param)
        if @user.valid?
            token = encode_token({user_id: @user_id})
            render json: {user: @user,token: token}
        else
            render json: {error: "Invalid Username or Password"}
        end
    end

    #LOGGED IN
    def login
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:username])
            token = encode_token({user_id: @user.id})
            render json: {user: @user ,token: token}
        else
            render json: {error: "Invalid Username or Password"}
        end
    end

    def auto_login
        render json: @user
    end

    private
    def user_params
        params.permit(:username, :password, :age)
    end 
end
