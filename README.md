# Schritt für Schritt Anleitung

Das Erstellen der Applikation ist relativ einfach:

* Generieren der Applikation
  `rails new url`
* Scaffolding des Models
  `rails generate scaffold link url:string`
* Einfügen von Gems in `Gemfile.rb`:

```ruby
gem 'jquery-rails'
gem 'jquery-datatables-rails'                        # Tables
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
```

* Gems installieren
  `bundle install`
* Datenbank migrieren
  `rake db:migrate`

### Twitter Bootstrap 

* Assets installieren
  `rails generate bootstrap:install static`
* Fixed Layout erstellen
  `rails g bootstrap:layout application fixed`
* Views behübschen mit Twitter Bootstrap  
  `rails generate bootstrap:themed Link`
* CSS modifizieren in 
  `\app\assets\stylesheets\bootstrap_and_overrides.css`
* Layout modifizieren in 
  `app\views\layouts\application.html.erb`

* Standardsprache Deutsch 
  in `app\config\application.rb` auskommentieren:
    config.i18n.default_locale = :de
* Übersetzungen 
  in `config/locales/de.yml`

### Datatables 

Javascript Library zum bequemeren Suchen, Filtern und zur Paginierung erfordert Anpassungen in 
* Laden der Javascript-Bibliothek `app\assets\javascripts\application.js`:

```ruby
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
```

* Laden des Stylesheets `app\assets\stylesheets\application.css`:

```ruby
*= require_self
*= require scaffolds
*= require bootstrap_and_overrides
*= require dataTables/jquery.dataTables.bootstrap 
```

* Die Übersetzung von Datatabels erfolgt in dataTables.de.txt
* Ein Helper für einfaches Instanzieren in `app\views\shared\_datatables_helper.html.erb` ermöglich Datatables-Tabell mit dem CSS-Klasse datatable plus der Instanzierung am Ende des Views.

```ruby
<%= render "shared/datatables_helper" %>
```

### Business Logik

Die Businesslogik beschränkt auf den Controller:

```ruby
class LinksController < ApplicationController
  before_filter :authenticate, :except => [:follow]

  def authenticate
    authenticate_or_request_with_http_basic do |ignore_user, password|
      password == 'mittenin.at'
    end
  end
  
  def follow
    @link = Link.find(params[:id])
    redirect_to @link.url
  end
```
Damit wird eine einfache http-Authentifizierung für den Administrationspart erzwungen.
Schlussendlich noch sorgen die Routes noch für einen Aufruf in der Form http://at.mittenin.at/42 zusätzlich zu http://at.mittenin.at/links/42/follow:

```ruby
Url::Application.routes.draw do
  resources :links do 
    member do
      get 'follow'
    end
  end

  root :to => "links#index"    
  match '(:id)', :controller => 'links', :action => 'follow'
end
```

Eine laufendes Demo gibt es <a href="http://at.mittenin.at">hier</a>.