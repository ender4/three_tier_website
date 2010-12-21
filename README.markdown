# Three Tier Website

This is a template for a simple 3 tiered website (Pages/Categories/Items)
serving mostly static data.

installation:


using the rails console create a super admin and a home page


custom domain
http://docs.heroku.com/custom-domains
http://docs.heroku.com/zerigo

get a domain from a registrar, I suggest 1and1.com, or look at regselect.com
  for other options
in heroku add 'Custom Domains - basic' add-on to app
in heroku, app, addons, custom domains add desired domain (e.g. www.app.com)
in heroku add 'Zerigo - basic' add-on to app
in heroku, app, addons, zerigo dns click configure next to domain
from registrar point dns to zerigo dns servers


amazon s3
http://docs.heroku.com/s3

signup for amazon aws, then amazon s3
signin to aws management console for s3
add buckets for app, app-development, and app-test
create file '/config/amazon_s3.yml' to app root directory
fill file as in the s3 doc above using your buckets, and keys (from your aws
  account -> security credentials)
