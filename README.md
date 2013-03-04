# Schritt für Schritt Anleitung

Das Erstellen der Applikation ist relativ einfach:

* Generieren der Applikation
  `rails new url`
* Scaffolding des Models
  `rails generate scaffold link url:string`
* Einfügen von Gems in 
  `Gemfile.rb`
```ruby
gem 'jquery-rails'
gem 'jquery-datatables-rails'                        # Tables
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
```

* Gems installieren
  `bundle install`
* Datenbank migrieren
  `rake db:migrate`
* Twitter Bootstrap 
** Assets installieren
   `rails generate bootstrap:install static`
** Fixed Layout erstellen
  `rails g bootstrap:layout application fixed`
** Views behübschen mit Twitter Bootstrap  
  `rails generate bootstrap:themed Link`
** CSS modifizieren in 
  `\app\assets\stylesheets\bootstrap_and_overrides.css`
** Layout modifizieren in 
  `app\views\layouts\application.html.erb`
* Standardsprache Deutsch 
  in `app\config\application.rb` auskommentieren:
    config.i18n.default_locale = :de
* Übersetzungen 
  in `config/locales/de.yml`
* Datatables Javascript Library zum bequemeren Suchen, Filtern und zur Paginierung erfordert Anpassungen in 
** `app\assets\javascripts\application.js`
```ruby
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
```
** `app\assets\stylesheets\application.css`
```ruby
*= require_self
*= require scaffolds
*= require bootstrap_and_overrides
*= require dataTables/jquery.dataTables.bootstrap 
```
** Die Übersetzung von Datatabels erfolgt in dataTables.de.txt
** Ein Helper für einfaches Instanzieren in `app\views\shared\_datatables_helper.html.erb`
   ermöglich Datatables-Tabell mit dem CSS-Klasse datatable plus der Instanzierung am Ende des Views.
```erb
<%= render "shared/datatables_helper" %>
```