#some of this came from http://www.claytoniz.com/index.php/2009/07/authlogic-account-activation-tutorial/

class User < ActiveRecord::Base
  has_many :models
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 6, :if => :has_no_credentials?}

    # c.my_config_option = my_value
  end

  attr_accessible :login, :email, :password, :password_confirmation, :openid_identifier
 
  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
 
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  # Pre-authlogic 2.0
  # acts_as_authentic :login_field_validation_options => { :if => :openid_identifier_blank? },
  #                   :password_field_validation_options => { :if => :openid_identifier_blank? },
  #                   :password_field_validates_length_of_options => { :on => :update, :if => :has_no_credentials? }
 
  # ...
  # we need to make sure that either a password or openid gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank? && self.openid_identifier.blank?
  end
 
  # ...
  # now let's define a couple of methods in the user model. The first
  # will take care of setting any data that you want to happen at signup
  # (aka before activation)
  def signup!(params)
    self.login = params[:user][:login]
    self.email = params[:user][:email]
    self.password = params[:user][:password]
    save_without_session_maintenance
  end
 
  # the second will take care of setting any data that you want to happen
  # at activation. at the very least this will be setting active to true
  # and setting a pass, openid, or both.
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    self.openid_identifier = params[:user][:openid_identifier]
    save
  end

  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end 

end
