class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable #:invitable, :confirmable,:validatable

  after_create :add_mailchimp_subscriber

private
  def add_mailchimp_subscriber
    client = Mailchimp::API.new('1b7b418d6647063fd6b864ada139236c-us14')
    client.lists.subscribe('b46d2081e0', {email: self.email})
  end

end
