require_relative 'concerns/slugable'
class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  include Slugable::InstanceMethods

  def self.find_by_slug(slug)
    self.all.find do |instance|
     instance.slug == slug
    end
  end

end
