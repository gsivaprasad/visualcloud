class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :aws_access_key, :aws_secret_key
  # TODO : Code Review : Maybe this should be moved to project level ?
  attr_encrypted :aws_secret_key, :key => VisualCloudConfig[:attr_encryption_salt]
  has_and_belongs_to_many :projects

  def get_key_pair_and_security_groups(region = nil)
    cloud = Cloudster::Cloud.new(access_key_id: aws_access_key, secret_access_key: aws_secret_key, region: region)
    key_pairs = cloud.get_key_pairs
    security_groups = cloud.get_security_groups
    return key_pairs, security_groups
  end
end
