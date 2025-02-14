# Capistrano Redmine deployment

## Usage

- Update the server entries for the relevant stage in `config/deploy/staging.rb` or `config/deploy/production.rb`
- Ensure the `MYSQL_HOST` and `MYSQL_PASSWORD` environmental variables are set. The Mysql host name should be a FQDN: `dbs-xxxxx.gb1.brightbox.com`
- Ensure the target application servers have `podman` installed. The deployment will error if `podman` is missing.
- Redmine will be exposed on port 3000 as usual.
- If there is more than one application server, then the container storage areas at `.local/share/containers/storage/volumes/redmine_data/_data/` will need syncing together. 
- Redmine is run under the user-level systemd of the user specified in the stage file (`fedora` for Fedora, `ubuntu` for Ubuntu, etc.)
- `cap <STAGE> deploy` to install and activate the Redmine container
- `cap <STAGE> quadlet:remove` to deactivate and remove the Redmine container
- Automatic updates are on. Use a more specific tag, or image hash for `redmine_container` to lock versions.

