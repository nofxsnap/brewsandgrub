# brewsandgrub

Use HomeBrew to install Postgresql
  brew install postgres

Init your Postgres DB (Do these inside the command line and not in postgres)
  initdb /Users/<your username>/.homebrew/var/postgres -E utf8

In another terminal, this command will run the PG DB, make sure to keep this running in the new terminal for the next few steps
  postgres -D /Users/<your username>/.homebrew/var/postgres

Create an admin user for the DB
  createuser adminbrews --superuser

Create a regular DB user
  createuser brewsbot

Create the DB
  createdb -Obrewsbot -Eutf8 brewsandgrub_development

To auto-start PG run these
  mkdir -p ~/Library/LaunchAgents
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

You can also install the Postgres client if you're running a Mac
  http://postgresapp.com/

  There is an entity-relationship diagram that provides a visualization of the model.
    docs/entity-relationship-diagram.pdf

  You can generate a new one at any time.  If you don't have it already you'll have to install Graphviz:
      brew install graphviz           # Homebrew on Mac OS X
      sudo apt-get install graphviz   # Debian and Ubuntu

  Then run the following rake task:
    rake erd filename='docs/entity-relationship-diagram'
