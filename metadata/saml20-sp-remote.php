<?php

$metadata['dev-plan.login.sfo.identity.team'] = array(
    'AssertionConsumerService' => 'https://dev-plan.login.sfo.identity.team/saml/SSO/alias/dev-plan.login.sfo.identity.team',
    'SingleLogoutService' => 'https://dev-plan.login.sfo.identity.team/saml/SingleLogout/alias/dev-plan.login.sfo.identity.team',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);

$metadata['http://dev-sso-auth-server/saml2/service-provider-metadata/okta'] = array(
    'AssertionConsumerService' => 'http://35.197.103.195:30697/login/saml2/sso/okta',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);

$metadata['http://localhost:8080/saml2/service-provider-metadata/okta'] = array(
    'AssertionConsumerService' => 'http://localhost:8080/login/saml2/sso/okta',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);

$metadata['http://localhost:9000/saml2/service-provider-metadata/okta'] = array(
    'AssertionConsumerService' => 'http://localhost:9000/login/saml2/sso/okta',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);

$metadata['http://auth-server:9000/saml2/service-provider-metadata/okta'] = array(
    'AssertionConsumerService' => 'http://auth-server:9000/login/saml2/sso/okta',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
