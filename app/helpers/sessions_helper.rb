module SessionsHelper

  def sign_in(user)
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    session[:user_id] = user.id   #set cookie

    #self.current_user = user
    @current_user = user
  end

  def deny_access
    #store_location #see private section below
    session[:return_to] = request.fullpath
    redirect_to(signin_path, :notice => "Please sign in to access the page")
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    #clear_return_to #see private section below
    session[:return_to] = nil
  end


=begin
  def current_user=(user)
    @current_user = user
  end

  def current_user
    #'hello'
    #@current_user ||= user_from_remember_token
  end

=end

=begin
  def current_user
    @current_user || get_user_from_cookie
  end

  def signed_in?
    !current_user.nil?
  end


  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
=end

  def signed_in?
    #get_user_from_cookie ? true : false
    get_user_from_session ? true : false
  end

  def sign_out
    #cookies.delete(:remember_token) 
    session.delete(:user_id)   #deltes the key named :user_id
    @current_user = nil
  end

  #def get_user_from_cookie
  def get_user_from_session
    @current_user || begin
      #cookie_array = cookies.signed[:remember_token] || [nil, nil]
      #@current_user = User.authenticate_with_salt(*cookie_array)
      @current_user = User.find_by_id( session[:user_id] )  #method returns this val
    end
  end

  def current_user?(user)
    @user == get_user_from_session
  end
  

  private
=begin
    def store_location
      session[:return_to] = request.fullpath
    end
    def clear_return_to
      session[:return_to] = nil
    end
end


=begin
  def get_user_from_cookie
    @current_user || begin
      cookie_array = cookies.signed[:remember_token]

      if cookie_array
        @current_user = User.authenticate_with_salt(*cookie_arr)
        return @current_user
      else
        return nil
      end

    end # || block
  end
=end
  #private
=begin

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

=end

=begin
  def get_user_from_cookie
    cookie_arr = cookies.signed[:remember_token]

    if cookie_arr 
      user_from_cookie = User.authenticate_with_salt(*cookie_arr)
      self.current_user = user_from_cookie 
      #calls setter method
      
      user_from_cookie  #using the getter will cause infinite
                        #loop if user_from_cookie is nil
    else
      nil
    end

  end
=end
end

   

