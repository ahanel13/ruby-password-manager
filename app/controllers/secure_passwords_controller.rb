class SecurePasswordsController < ApplicationController
  before_action :set_secure_password, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /secure_passwords
  # GET /secure_passwords.json
  def index
    @secure_passwords = SecurePassword.where(:user_id => current_user.id)
  end

  # GET /secure_passwords/1
  # GET /secure_passwords/1.json
  def show
    @cipher = OpenSSL::Cipher.new 'AES-256-CBC'
    @cipher.decrypt

    @pwd = current_user.encrypted_password
    @salt = '0123asdf;lkj9876'
    @iter = 20000
    @key_len = @cipher.key_len
    @digest = OpenSSL::Digest.new('SHA256')

    puts "========================"
    puts "salt: #{@salt}"  
    puts "iter: #{@iter}"  
    puts "key_len: #{@key_len}"
    puts "digest: #{@digest}" 

    @key = OpenSSL::PKCS5.pbkdf2_hmac(@pwd, @salt, @iter, @key_len, @digest)
    @cipher.key = @key
    
    puts "key: #{@key}"

    #Now decrypt the data:
    @decoded = Base64.decode64(@secure_password.password).encode('ascii-8bit')
    @decrypted = @cipher.update @decoded
    @decrypted << @cipher.final
    puts "decrypted password: #{@decrypted}"
    puts "========================"

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
    @secure_password[:user_id] = current_user.id
    
    #generating random password
    require 'securerandom'
    @length = 16
    @random_password = SecureRandom.base64(@length)

    #encrypting all the data
    @cipher = OpenSSL::Cipher.new 'AES-256-CBC'
    @cipher.encrypt

    @pwd = current_user.encrypted_password
    @salt = '0123asdf;lkj9876'
    @iter = 20000
    @key_len = @cipher.key_len
    @digest = OpenSSL::Digest.new('SHA256')

    puts "========================"
    puts "randomly generated password: #{@random_password}" 
    puts "salt: #{@salt}"  
    puts "iter: #{@iter}"  
    puts "key_len: #{@key_len}"
    puts "digest: #{@digest}" 

    @key = OpenSSL::PKCS5.pbkdf2_hmac(@pwd, @salt, @iter, @key_len, @digest)
    @cipher.key = @key
    puts "key: #{@key}"
    puts "========================"

    @encrypted_random_password = @cipher.update @random_password
    @encrypted_random_password << @cipher.final
    @secure_password[:password] = encoded = Base64.encode64(@encrypted_random_password).encode('utf-8')
    
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
      format.html { redirect_to dashboard_index_path, notice: 'Secure password was successfully destroyed.' }
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
