# encoding: utf-8
# PGonror is the corporate web site framework of Le Parti de Gauche based on Ruby on Rails.
# 
# Copyright (C) 2012 Le Parti de Gauche
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# 
# See doc/COPYRIGHT.rdoc for more details.

# Defines subscriptions the users can apply in order to receive further information.
class Subscription < ActiveRecord::Base
  validates :first_name, :length => {:minimum => 3, :maximum => 30}
  validates :last_name, :length => {:minimum => 3, :maximum => 30}
  validates :address, :length => {:maximum => 80}
  validates :zip_code, :length => {:maximum => 10}
  validates :city, :length => {:maximum => 80}
  validates :phone, :length => {:maximum => 30}
  validates :email, :length => {:minimum => 3, :maximum => 50}, :email => true
  
  # Setup accessible (or protected) attributes for the model.
  attr_accessible :last_name,
                  :first_name,
                  :email,
                  :address,
                  :zip_code,
                  :city,
                  :phone

  # For logs in Administration panel
  paginates_per 100
  scope :logs, order('created_at DESC')
  scope :filtered_by, lambda { |search| where('lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(email) LIKE ?', "%#{search.downcase.strip}%", "%#{search.downcase.strip}%", "%#{search.downcase.strip}%") }
  
  # Returns the content as a string used for display.  
  def to_s
    "#{I18n.l(created_at)} : #{first_name} #{last_name} (#{email})"
  end
end