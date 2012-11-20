class ResourceType < ActiveRecord::Base
  attr_accessible :ami_id, :large_icon, :name, :small_icon, :resource_class, :description, :parents_list

  has_many :instances
  has_many :instance_types
end
