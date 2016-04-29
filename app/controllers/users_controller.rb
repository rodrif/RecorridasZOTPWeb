class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin

  def index
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific],
      select_options: {
        with_area_id: Area.options_for_select
      },
      default_filter_params: {}
    ) or return
    @users = @filterrific.find.activos.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /user/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params_update)
        format.html { redirect_to users_url, notice: 'Usuario actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    UserDataAccess.borrar_logico(@user)
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :apellido, :area_id, :rol_id, :email)
    end

    def user_params_update
      params.require(:user).permit(:name, :apellido, :area_id, :rol_id)
    end

end
