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
module RequestMacros
  def login_user(level = :user)
    before(:each) do
      user = FactoryGirl.create(level.to_sym)
      user.confirm!
      
      visit new_user_session_path
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      click_button 'Accès adhérents'
    end
  end
end