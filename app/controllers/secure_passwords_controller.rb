class SecurePasswordsController < ApplicationController
  before_action :set_secure_password, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /secure_passwords
  # GET /secure_passwords.json
  def index
    @secure_passwords = SecurePassword.all
  end

  # GET /secure_passwords/1
  # GET /secure_passwords/1.json
  def show
  end

  # GET /secure_passwords/new
  def new
    @secure_password = SecurePassword.new
  end

  # GET /secure_passwords/1/edit
  def edit
  end

  # POST /secure_passwords
  # POST /secure_passwords.json
  def create
    @secure_password = SecurePassword.new(secure_password_params)

    respond_to do |format|
      if @secure_password.save
        format.html { redirect_to @secure_password, notice: 'Secure password was successfully created.' }
        format.json { render :show, status: :created, location: @secure_password }
      else
        format.html { render :new }
        format.json { render json: @secure_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secure_passwords/1
  # PATCH/PUT /secure_passwords/1.json
  def update
    respond_to do |format|
      if @secure_password.update(secure_password_params)
        format.html { redirect_to @secure_password, notice: 'Secure password was successfully updated.' }
        format.json { render :show, status: :ok, location: @secure_password }
      else
        format.html { render :edit }
        format.json { render json: @secure_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secure_passwords/1
  # DELETE /secure_passwords/1.json
  def destroy
    @secure_password.destroy
    respond_to do |format|
      format.html { redirect_to secure_passwords_url, notice: 'Secure password was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secure_password
      @secure_password = SecurePassword.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secure_password_params
      params.require(:secure_password).permit(:url, :name, :notes, :password)
    end
end
