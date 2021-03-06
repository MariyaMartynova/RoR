class UsersController < ApplicationController


  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.active_code=rand(Time.now.to_i).to_s#生成随机码
    @user.is_active=false

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to(root_path, :notice => "Confirmation email has been sent to #{@user.email}, please active it!") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  def address
    @user=User.find(params[:id])
    @address=@user.address
  end
  #active user
  def active_user
    @user=User.find_by_email(params[:email])
    code=params[:code]
    respond_to do |format|
    if(@user.active_code==code)
      @user.toggle(:is_active)
      flash[:notice]="You have succefull actived your account!"
      @user.save
      format.html { redirect_to (@user) }
      format.xml  { render :xml => @user }
    else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    end
  end
  end
  #recover password?
  def recover_password
    @title ="Recover password"
    if request.post?
      email=params[:find_password_email]
      @user=User.find_by_email(email)
      if !@user
       redirect_to(signin_path, :notice => 'The email address is not exsit!')
      else
       UserMailer.recover_password(@user).deliver
       redirect_to(signin_path, :notice => "Reset password link has been sent to #{@user.email}")
      
      end
    else
      email=params[:email]
      code=params[:code]
      @user=User.find_by_email(email)
      if @user.active_code=code
        redirect_to(reset_password_path(:email=>email), :notice => 'Please reset your password')
      else
        redirect_to(signin_path, :notice => 'Please try again')
      end
    end    
  end

  #forget password?
  def forget_password
    @title ="Forget password"
   
  end
  def reset_password
    @title="reset password"
    @email=params[:email]
   if request.post?
     email=params[:email]
     @user=User.find_by_email(email)
     password=params[:reset_password]
     @user.active_code=rand(Time.now.to_i).to_s#生成随机码
     @user.password=password
     @user.save
     redirect_to(signin_path, :notice => 'You can login with your new password')
   end
  end
end
