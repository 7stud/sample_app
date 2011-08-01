module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    #self.current_user = user
    @current_user = user
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
    get_user_from_cookie ? true : false
  end

  def sign_out
    cookies.delete(:remember_token) 
    @current_user = nil
  end

  def get_user_from_cookie
    @current_user || begin
      cookie_array = cookies.signed[:remember_token] || [nil, nil]
      @current_user = User.authenticate_with_salt(*cookie_array)
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



