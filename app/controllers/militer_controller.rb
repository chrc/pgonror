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
class MiliterController < ApplicationController
  before_filter :find_article, :only => [:evenement, :tract, :affiche, :kit]
  before_filter :load_side_articles, :only => [:index, :inscription, 
                                               :evenement, :agenda, 
                                               :kits, :kit, 
                                               :tracts, :tract, 
                                               :affiches, :affiche]

  caches_action :index, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :agenda, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :tracts, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :kits, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :affiches, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :rss

  def index
    create_subscription
  end
  
  def evenement
  end

  def agenda
    @articles = Article.find_published_order_by_start_datetime 'evenement', @page
    @pages = Article.count_pages_published_by_start_datetime 'evenement'
  end

  # RSS output based on recent articles.
  def rss
    @articles = Article.find_published_order_by_start_datetime 'evenement', 1, 50
    render :template => 'layouts/rss'
  end
  
  def tracts
    @articles = Article.find_published 'tract', @page
    @pages = Article.count_pages_published 'tract'
  end

  def tract
  end

  def kits
    @articles = Article.find_published 'kit', @page
    @pages = Article.count_pages_published 'kit'
  end

  def kit
  end

  def affiches
    @articles = Article.find_published 'affiche', @page
    @pages = Article.count_pages_published 'affiche'
  end

  def affiche
  end

  def inscription
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      flash.now[:notice] = t('action.subscription.created')
      recipients = User.notification_recipients "notification_subscription"
      if not recipients.empty?
        Notification.notification_subscription(@subscription.email, 
                                               recipients.join(', '),
                                               t('mailer.notification_subscription_subject'),
                                               @subscription.first_name,
                                               @subscription.last_name, 
                                               @subscription.email, 
                                               @subscription.address, 
                                               @subscription.zip_code,
                                               @subscription.city, 
                                               @subscription.phone).deliver
      end
      Receipt.receipt_subscription(Devise.mailer_sender, 
                                   @subscription.email,
                                   t('mailer.receipt_subscription_subject'),
                                   @subscription.first_name,
                                   @subscription.last_name).deliver
      create_subscription
    end
    render :action => "index"
  end

private

  def create_subscription
    @subscription = Subscription.new
  end

  def load_side_articles
    @campagne = Article.find_published('campagne', 1, 1)[0]
    @tracts = Article.find_published 'tract', 1, 1
    @kits = Article.find_published 'kit', 1, 1
    @affiches = Article.find_published 'affiche', 1, 1
    @evenements = Article.find_published_order_by_start_datetime 'evenement', 1, 15
  end
end