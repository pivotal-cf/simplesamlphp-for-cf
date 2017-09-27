SimpleSAMLphp
=============

This is NOT the official repository of the SimpleSAMLphp software.

* [Original Source Repo](https://github.com/simplesamlphp)
* [SimpleSAMLphp homepage](https://simplesamlphp.org)
* [SimpleSAMLphp Downloads](https://simplesamlphp.org/download)

This is a code fork for the simplesamlphp in it's configured, ready to deploy to Cloud Foundry format.

This is used for the PCF Ops Manager team for development purposes.


User login: admin / password <br />
Additional user login: user / password <br />
SAML Administrator login: admin / pizza9pixel


### Running a SAML server for local testing

Install php binary if it is not installed. 

Start the server from the www directory:
```bash
cd www
php -S 127.0.0.1:5000
```

If you need to change the port to something other than `5000`, you will need to add your domain to `trusted.url.domains` in config/config.php.


The IDP metadata is in the Federation tab. If you followed the above set up, here it is for quick reference: `http://127.0.0.1:5000/saml2/idp/metadata.php`


#### For testing groups

There is a groups attribute called `snack-groups`. Look in config/authsources.php for group definitions for each user.
The `admin:password` user is the only member of a group called `pretzel-admins`. 
