<?php

$metadata['opsman-login'] = array(
    'AssertionConsumerService' => 'http://localhost:8080/uaa/saml/SSO/alias/opsman-login',
    'SingleLogoutService' => 'http://localhost:8080/uaa/saml/SSO/alias/opsman-login',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
