<?php

$metadata['http://localhost:8080/uaa'] = array(
    'AssertionConsumerService' => 'http://localhost:8080/uaa/saml/SSO/alias/localhost',
    'SingleLogoutService' => 'http://localhost:8080/uaa/saml/SSO/alias/localhost',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
    'HTTP-Redirect' => 'http://localhost:8080/uaa/saml/SSO/alias/localhost'
);
