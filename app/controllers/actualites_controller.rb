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
class ActualitesController < ApplicationController
  before_filter :find_article, :only => [:edito, :actualite, :communique, :international, :dossier]
  before_filter :load_side_articles, :only => [:edito, :editos, 
                                               :actualite, :actualites, 
                                               :communique, :communiques, 
                                               :international, :tout_international,
                                               :dossier, :dossiers]

  caches_action :index, :layout => false, :if => Proc.new { not user_signed_in? }
  caches_action :editos, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? } 
  caches_action :actualites, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :communiques, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :tout_international, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }
  caches_action :dossiers, :layout => false, :if => Proc.new { @page == 1 and not user_signed_in? }

  def index
    @editos = Article.find_published 'edito', 1, 15
    @dossiers = Article.find_published 'dossier', 1, 15
    @communiques = Article.find_published 'com', 1, 3
    @actus = Article.find_published 'actu', 1, 3
    @tout_international = Article.find_published 'inter', 1, 3
  end

  def editos
    @pages = Article.count_pages_published 'edito'
    @articles = Article.find_published 'edito', @page
  end

  def edito
  end

  def actualites
    @pages = Article.count_pages_published 'actu'
    @articles = Article.find_published 'actu', @page
  end

  def actualite
  end

  def communiques
    @pages = Article.count_pages_published 'com'
    @articles = Article.find_published 'com', @page
  end

  def communique
  end

  def tout_international
    @pages = Article.count_pages_published 'inter'
    @articles= Article.find_published 'inter', @page
  end

  def international
  end

  def dossiers
    @pages = Article.count_pages_published 'dossier'
    @articles = Article.find_published 'dossier', @page
  end

  def dossier
  end
  
private

  def load_side_articles
    @actus = Article.find_published 'actu', 1, 1
    @editos = Article.find_published 'edito', 1, 1
    @communiques = Article.find_published 'com', 1, 1
    @tout_international = Article.find_published 'inter', 1, 1
    @dossiers = Article.find_published 'dossier', 1, 1
  end
end