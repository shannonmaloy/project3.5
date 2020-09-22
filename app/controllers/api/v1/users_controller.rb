class Api::V1::UsersController < ApplicationController
    
    #GET /users
    def index
        @users = User.all
        render json: @users
    end

    # GET /user/:id
    def show
        if @user
            @user = User.find(params[:id])
            render json: @user
        else
            render error: {error: "Could Not Find User ID:#{:id}"}
        end
    end

    #POST /users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user
        else
            render error: {error: "Unable to create User"}, status: 400
        end
    end

    #PUT /users/:id
    def update
        @user = User.find(params[:id])
        if @user
            @user.update(user_params)
            
            render json: {message: "User Successfully Updated"}, status: 200
        else
            render json: {error: "Unable to Update User"}, status:400
        end
    end

    #DELETE /users/:id
    def destroy
        @user = User.find(params[:id])
        if @user
            @user.destroy
            render json: {message: 'User Successfuly Deleted!'}, status: 200
        else
            render json: {error: "Unable to delete User"}, status: 400
        end
    end

    private
    # It provides an interface for protecting attributes from end-user assignment. 
    #This makes Action Controller parameters forbidden to be used 
    #in Active Model mass assignment until they have been explicitly enumerated.
    def user_params
        params.require(:user).permit(:username, :password)
    end

end



