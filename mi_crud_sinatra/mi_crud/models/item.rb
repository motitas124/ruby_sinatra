class Item < ActiveRecord::Base
  validates :name, presence: { message: 'El nombre es obligatorio' }
end
