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

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initializes the rails application
PartiDeGauche::Application.initialize!

# Turns off auto TLS for e-mail.
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

# Configures the content of the main menu.
MENU = [ 
  ["Accueil", {:controller => :accueil, 
               :action => :index, 
               :description => "Créé le 29 novembre 2008, le Parti de Gauche fait le lien entre l'urgence écologique, la crise sociale et républicaine de la France et du monde pour proposer une orientation de rupture avec le capitalisme et le productiviste ainsi qu'un renouveau républicain des institutions. Il est un parti creuset qui réunit des militant-e-s de divers horizons : altermondialistes, communistes, écologistes, libertaires, socialistes... ils et elles croient en la révolution par les urnes, en la planification écologique et en l'éducation populaire."}],
  ["Actualités", {:controller => :actualites, :action => :index}],
  ["Arguments - Programme", {:controller => :arguments, :action => :index}],
  ["Militer", {:controller => :militer, :action => :index}],
  ["Éduc Pop", {:controller => :educpop, :action => :index}],
  ["Qui sommes-nous ?", {:controller => :quisommesnous, :action => :index}],
  ["Vu d’ailleurs", {:controller => :vudailleurs, :action => :index}],
  ["Contact", {:controller => :contact, :action => :index}],
  ["À Gauche", {:controller => :accueil, :action => :agauche, :hide => true}],
  ["Gavroche", {:controller => :accueil, :action => :gavroche, :hide => true}],
  ["Recherche", {:controller => :accueil, :action => :search, :hide => true}],
  ["Adhésion au Parti de Gauche", {:controller => :memberships, :action => :adhesion, :hide => true}],
  ["Don au Parti de Gauche", {:controller => :donations, :action => :don, :hide => true}],
  ["Photos", {:controller => :photos, :action => :index, :hide => true}],
  ["Vidéos", {:controller => :videos, :action => :index, :hide => true}],
  ["Vie de Gauche", {:controller => :viedegauche, :action => :index, :hide => true}],
  ["Télé de Gauche", {:controller => :videos, :action => :lateledegauche, :hide => true}],
  ["À la une", {:controller => :accueil, 
                :action => :rss, 
                :hide => true,
                :description => "Actualités du Parti de Gauche - Écologie, Socialisme, République"}],
  ["Agenda", {:controller => :militer, 
              :action => :rss, 
              :hide => true,
              :description => "Agenda du Parti de Gauche - Écologie, Socialisme, République"}],
  ["Podcat", {:controller => :podcast, 
              :action => :rss, 
              :hide => true,
              :description => "Podcast du Parti de Gauche - Écologie, Socialisme, République"}]
]

# Configures the supported types of content (categories) for articles.
# The first element defines the displayed label of the article category.
# The second element defines the stored article category code.
# The third element defines options that apply for the article category.
#  :signature (boolean) includes a signature to articles
#  :parent (boolean) sets the category as a parent for other categories (as folders). 
#  :source (boolean) sets the category as a source of information for other categories.
#  :image (boolean) sets the category as a reference to an image.
#  :document (boolean) sets the category as a reference to a document.
#  :controller sets the controller used in the website to display the article of the same category.
#  :action_all sets the action used in the website to display the list of article of the same category.
#  :action sets the action used in the website to display one article of the same category.
#  :category_title sets the title of category to be displayed in the website.
#  :link_all_title sets the title of a link to a list of article of the same category to be displayed in the website.
#  :start_end_dates includes a start and a end date and time.
#  :address includes an address.
#  :audio indicates the content is an audio file.
#  :video indicates the content is a video.
#  :searchable includes the article category in the searches.
#  :unfeedable excludes the article category from the feeds.
#  :access_level is related to the access to public or protected users.
#  :email defines an email address attached to the category.
#  :hide_category_name hides the name of the category.
CATEGORIES = [
              ["À GAUCHE", 'presentation_agauche'],
              ["AFFICHE", 'affiche', {:searchable => true,
                                      :controller => :militer,
                                      :action_all => :affiches,
                                      :action => :affiche,
                                      :category_title => "AFFICHES",
                                      :link_all_title => "VOIR TOUTES LES AFFICHES"}],
              ["ACTUALITÉ", 'actu', {:signature => true,
                                     :searchable => true,
                                     :controller => :actualites,
                                     :action_all => :actualites,
                                     :action => :actualite,
                                     :category_title => "ACTUALITÉS",
                                     :link_all_title => "LIRE TOUTES LES ACTUALITÉS"}],
              ["ADHÉSION", 'adhesion'],
              ["ARGUMENT", 'argument', {:signature => true,
                                        :searchable => true,
                                        :controller => :arguments,
                                        :action_all => :arguments,
                                        :action => :argument,
                                        :category_title => "ARGUMENTS",
                                        :link_all_title => "LIRE TOUS LES ARGUMENTS"}],
              ["ARTICLE DIVERS (NON CLASSÉ)", 'divers'],
              ["ARTICLE VIE DE GAUCHE", 'articlevdg', {:signature => true,
                                                       :searchable => true,
                                                       :controller => :viedegauche,
                                                       :action_all => :index,
                                                       :action => :article,
                                                       :category_title => "VIE DE GAUCHE",
                                                       :link_all_title => "VOIR TOUS LES ARTICLES"}],
              ["BLOG", 'blog', {:searchable => true,
                                :source => true,
                                :controller => :vudailleurs,
                                :action_all => :blogs,
                                :action => :blog,
                                :category_title => "BLOGS",
                                :link_all_title => "ACCÉDER À LA LISTE DES BLOGS"}],
              ["CAMPAGNE", 'campagne', {:hide_category_name => true,
                                        :controller => :militer,
                                        :action_all => :index,
                                        :action => :index,
                                        :category_title => "CAMPAGNE"}],
              ["CAMPAGNE EN LIGNE", 'campagne_enligne', {:searchable => true,
                                                         :controller => :militer,
                                                         :action_all => :index,
                                                         :action => :index,
                                                         :category_title => "CAMPAGNES EN LIGNE"}],
              ["CIRCULAIRE ADHÉRENTS", 'circulaire', {:access_level => :reserved,
                                                      :controller => :adherent,
                                                      :action_all => :index,
                                                      :action => :article}],
              ["ARCHIVE CODES SOURCE", 'codearchive', {:parent => true,
                                                       :signature => true,
                                                       :controller => :legal,
                                                       :action_all => :index,
                                                       :action => :archive,
                                                       :category_title => "ARCHIVES CODES SOURCE"}],
              ["CODE SOURCE", 'code', {:signature => true,
                                       :controller => :legal,
                                       :action => :source,
                                       :category_title => "CODES SOURCE",
                                       :unfeedable => true}],
              ["COMMISSION FONCTIONNELLE", 'commission_fonc', {:email => true}],
              ["COMMISSION THÉMATIQUE", 'commission_them', {:email => true}],
              ["COMMUNIQUÉ", 'com', {:signature => true,
                                     :searchable => true,
                                     :controller => :actualites,
                                     :action_all => :communiques,
                                     :action => :communique,
                                     :category_title => "COMMUNIQUÉS",
                                     :link_all_title => "LIRE TOUS LES COMMUNIQUÉS"}],
              ["CONFÉRENCE ET DISCOURS", 'conference', {:searchable => true,
                                                        :video => true,
                                                        :controller => :videos,
                                                        :action_all => :conferences,
                                                        :action => :conference,
                                                        :category_title => "CONFÉRENCES ET DISCOURS",
                                                        :link_all_title => "TOUTES LES CONFÉRENCES ET DISCOURS"}],
              ["CONSEIL", 'conseil', {:access_level => :reserved,
                                      :controller => :adherent,
                                      :action_all => :index,
                                      :action => :article}],
              ["CONTACT", 'contact', {:controller => :contact,
                                      :action_all => :index,
                                      :action => :index,
                                      :category_title => "CONTACTS"}],
              ["CONTACT COMITÉ", 'departement', {:searchable => true,
                                                 :source => true, 
                                                 :controller => :contact,
                                                 :action_all => :index,
                                                 :action => :departement,
                                                 :category_title => "POUR CONTACTER LE PARTI DE GAUCHE PRES DE CHEZ VOUS"}],
              ["C’EST ARRIVÉ PRÈS DE CHEZ VOUS", 'videoevenement', {:searchable => true,
                                                                    :video => true,
                                                                    :controller => :videos,
                                                                    :action_all => :videospresdechezvous,
                                                                    :action => :presdechezvous,
                                                                    :category_title => "C’EST ARRIVÉ PRÈS DE CHEZ VOUS",
                                                                    :link_all_title => "TOUT CE QUI EST ARRIVÉ"}],
              ["DIAPORAMA", 'diaporama', {:parent => true,
                                          :unfeedable => true,
                                          :controller => :photos,
                                          :action_all => :index,
                                          :action => :diaporama,
                                          :category_title => "DIAPORAMAS",
                                          :link_all_title => "TOUS LES DIAPORAMAS"}],
              ["DIRECT DE BLOG", 'directblog', {:signature => true,
                                                :searchable => true,
                                                :controller => :vudailleurs,
                                                :action_all => :articlesblog,
                                                :action => :articleblog,
                                                :category_title => "EN DIRECT DES BLOGS",
                                                :link_all_title => "VOIR TOUS LES ARTICLES"}],
              ["DOCUMENT", 'document', {:document => true,
                                        :unfeedable => true}],
              ["DOCUMENT UTILE", 'doc-utile', {:access_level => :reserved,
                                               :controller => :adherent,
                                               :action_all => :index,
                                               :action => :article}],
              ["DON", 'don'],
              ["DOSSIER", 'dossier', {:signature => true,
                                      :searchable => true,
                                      :controller => :actualites,
                                      :action_all => :dossiers,
                                      :action => :dossier,
                                      :category_title => "DOSSIERS",
                                      :link_all_title => "VOIR TOUS LES DOSSIERS"}],
              ["ÉDITO", 'edito', {:signature => true,
                                  :searchable => true,
                                  :controller => :actualites,
                                  :action_all => :editos,
                                  :action => :edito,
                                  :category_title => "ÉDITOS",
                                  :link_all_title => "LIRE TOUS LES ÉDITOS"}],
              ["ÉVÉNEMENT", 'evenement', {:searchable => true,
                                          :unfeedable => true,
                                          :start_end_dates => true,
                                          :address => true,
                                          :controller => :militer,
                                          :action_all => :agenda,
                                          :action => :evenement,
                                          :category_title => "AGENDA",
                                          :link_all_title => "VOIR L’AGENDA"}],
              ["GAVROCHE", 'presentation_gavroche'],
              ["IDENTITÉ", 'identite', {:controller => :quisommesnous,
                                        :action_all => :index,
                                        :action => :identite,
                                        :category_title => "IDENTITÉ"}],
              ["IMAGE", 'image', {:image => true,
                                  :unfeedable => true,
                                  :signature => true,
                                  :controller => :photos,
                                  :action_all => :index,
                                  :category_title => "PHOTOS",
                                  :link_all_title => "VOIR TOUTES LES PHOTOS"}],
              ["INSTANCE NATIONALE", 'instance', {:searchable => true,
                                                  :source => true,
                                                  :controller => :quisommesnous,
                                                  :action_all => :index,
                                                  :action => :instance,
                                                  :category_title => "INSTANCES NATIONALES"}],
              ["INTERNATIONAL", 'inter', {:signature => true,
                                          :searchable => true,
                                          :controller => :actualites,
                                          :action_all => :tout_international,
                                          :action => :international,
                                          :category_title => "INTERNATIONAL",
                                          :link_all_title => "TOUT L’INTERNATIONAL"}],
              ["JOURNAL VIE DE GAUCHE", 'vdg', {:searchable => true,
                                                :controller => :viedegauche,
                                                :action_all => :journauxvdg,
                                                :action => :journalvdg,
                                                :category_title => "JOURNAL VIE DE GAUCHE",
                                                :link_all_title => "VOIR LES ARCHIVES"}],
              ["LECTURE", 'lecture', {:searchable => true,
                                      :controller => :educpop,
                                      :action_all => :lectures,
                                      :action => :lecture,
                                      :category_title => "FICHES DE LECTURE",
                                      :link_all_title => "TOUTES LES FICHES DE LECTURE"}],
              ["LÉGISLATIVES : CE QUE L’ON VEUT !", 'legislative', {:signature => true,
                                                                    :searchable => true,
                                                                    :controller => :arguments,
                                                                    :action_all => :legislatives,
                                                                    :action => :legislative,
                                                                    :category_title => "LEGISLATIVES",
                                                                    :link_all_title => "LIRE TOUTES LES QUESTIONS"}],
              ["LETTRE D’INFORMATION", 'information'],
              ["KIT MILITANT", 'kit', {:searchable => true,
                                       :controller => :militer,
                                       :action_all => :kits,
                                       :action => :kit,
                                       :category_title => "KITS MILITANTS",
                                       :link_all_title => "VOIR TOUS LES KITS MILITANTS"}],
              ["LIVRE MILITANT", 'livre', {:searchable => true,
                                           :controller => :educpop,
                                           :action_all => :librairie,
                                           :action => :livre,
                                           :category_title => "LIBRAIRIE MILITANTE",
                                           :link_all_title => "DÉCOUVRIR TOUTES LES PARUTIONS"}],
              ["MÉDIA", 'media', {:searchable => true,
                                  :video => true,
                                  :controller => :videos,
                                  :action_all => :medias,
                                  :action => :media,
                                  :category_title => "MÉDIAS",
                                  :link_all_title => "TOUS LES PASSAGES MÉDIA"}],
              ["MENTIONS LÉGALES", 'legal'],
              ["PÔLES ET COMMISSIONS", 'commission', {:searchable => true,
                                                      :controller => :quisommesnous,
                                                      :action_all => :index,
                                                      :action => :commission,
                                                      :category_title => "PÔLES ET COMMISSIONS"}],
              ["PROGRAMME", 'programme', {:signature => true,
                                          :searchable => true,
                                          :controller => :arguments,
                                          :action_all => :leprogramme,
                                          :action => :programme,
                                          :category_title => "PROGRAMME PARTAGÉ",
                                          :link_all_title => "LIRE LE PROGRAMME"}],
              ["RÉPERTOIRE", 'directory', {:parent => true, :unfeedable => true}],
              ["REVUE", 'revue', {:searchable => true,
                                  :controller => :educpop,
                                  :action_all => :revues,
                                  :action => :revue,
                                  :category_title => "REVUES À GAUCHE",
                                  :link_all_title => "VOIR TOUS LES NUMÉROS"}],
              ["TRACT ET LOGO", 'tract', {:searchable => true,
                                          :controller => :militer,
                                          :action_all => :tracts,
                                          :action => :tract,
                                          :category_title => "TRACTS ET LOGOS",
                                          :link_all_title => "TOUS LES TRACTS ET LOGOS"}],
              ["UNE DATE, UN JOUR", 'date', {:signature => true,
                                             :searchable => true,
                                             :controller => :educpop,
                                             :action_all => :dates,
                                             :action => :date,
                                             :category_title => "UNE DATE, UN JOUR",
                                             :link_all_title => "VOIR LES ARCHIVES"}],
              ["SON", 'son', {:audio => true,
                              :signature => true,
                              :unfeedable => true,
                              :controller => :podcast,
                              :action_all => :index,
                              :action => :son,
                              :category_title => "PODCAST",
                              :link_all_title => "TOUS LES EPISODES"}],
              ["AGIT’PROP", 'videoagitprop', {:searchable => true,
                                              :video => true,
                                              :controller => :videos,
                                              :action_all => :videosagitprop,
                                              :action => :agitprop,
                                              :category_title => "VIDÉOS AGIT’PROP",
                                              :link_all_title => "TOUTES LES VIDÉOS AGIT’PROP"}],
              ["VIDÉO", 'video', {:signature => true,
                                  :searchable => true,
                                  :video => true,
                                  :controller => :videos,
                                  :action_all => :index,
                                  :action => :video,
                                  :category_title => "VIDÉOS",
                                  :link_all_title => "VOIR TOUTES LES VIDÉOS"}],
              ["ÉDUC POP", 'videoeduc', {:searchable => true,
                                         :video => true,
                                         :controller => :videos,
                                         :action_all => :touteducpop,
                                         :action => :educpop,
                                         :category_title => "VIDÉOS ÉDUC POP",
                                         :link_all_title => "TOUTES LES VIDÉOS ÉDUC POP"}],
              ["EN CAMPAGNE", 'encampagne', {:searchable => true,
                                             :video => true,
                                             :controller => :videos,
                                             :action_all => :videosencampagne,
                                             :action => :encampagne,
                                             :category_title => "VIDÉOS EN CAMPAGNE",
                                             :link_all_title => "TOUTES LES VIDÉOS EN CAMPAGNE"}],
              ["FRONT DE GAUCHE", 'videofdg', {:searchable => true,
                                               :video => true,
                                               :controller => :videos,
                                               :action_all => :videosfdg,
                                               :action => :fdg,
                                               :category_title => "VIDÉOS FRONT DE GAUCHE",
                                               :link_all_title => "TOUTES LES VIDÉOS FRONT DE GAUCHE"}],
              ["VU D’AILLEURS", 'web', {:signature => true,
                                        :searchable => true,
                                        :controller => :vudailleurs,
                                        :action_all => :articlesweb,
                                        :action => :articleweb,
                                        :category_title => "VU D’AILLEURS",
                                        :link_all_title => "VOIR TOUS LES ARTICLES"}]
             ]
              
# Defines access level for visitors.
ACCESS_LEVELS = [["Public", 'public'], ["Adhérent", 'reserved']]

# Defines Paybox configuration for memberships and donations
PBX_CGI = "/cgi-bin/paybox.cgi" 
PBX_PAYBOX_TEST = "https://preprod-tpeweb.paybox.com/cgi/MYchoix_pagepaiement.cgi"
PBX_SITE = "5133308"
PBX_SITE_TEST = "1999888"
PBX_RANG = "01"
PBX_RANG_TEST = "99"
PBX_IDENTIFIANT = "2"
PBX_IDENTIFIANT_TEST = "2"
PBX_MODE = "1"
PBX_LANGUE = "FRA"
PBX_DEVISE = "978"
PBX_RETOUR = "erreur:E;numauto:A;transac:T;id:R"
PBX_WAIT = "6000"
PBX_BOUTPI = "nul"