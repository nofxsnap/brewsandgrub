# brewsandgrub

Use HomeBrew to install Postgresql

brew install postgres
Init your Postgres DB (Do these inside the command line and not in postgres)

initdb /Users/<your username>/.homebrew/var/postgres -E utf8
In another terminal, this command will run the PG DB, make sure to keep this running in the new terminal for the next few steps

postgres -D /Users/<your username>/.homebrew/var/postgres
Create an admin user for the DB

createuser adminbot --superuser
Create a regular DB user

createuser bot
Create the DB

createdb -Obot -Eutf8 expensebot_development
To auto-start PG run these

mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
You can also install the Postgres client if you're running a Mac

http://postgresapp.com/
