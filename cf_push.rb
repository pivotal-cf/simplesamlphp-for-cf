#!/usr/bin/env ruby

def self.run(cmd)
  system(cmd) or raise "Failed to run #{cmd}"
end

def prompt(string)
  print string
  STDOUT.flush
  gets.strip
end

puts "Welcome #{`whoami`.strip}!"

opsman_ip = prompt "What IP or hostname (with port) would you like this SAML server to accept traffic from? "

File.write('metadata/saml20-sp-remote.php', <<-PHP)
<?php

$metadata['opsman-login'] = array(
    'AssertionConsumerService' => 'https://#{opsman_ip}/uaa/saml/SSO/alias/opsman-login',
    'SingleLogoutService' => 'https://#{opsman_ip}/uaa/saml/SSO/alias/opsman-login',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
PHP

prompt "Hit return to cf push ops-manager-saml-acceptance to your default space and credentials."

run 'cf push -f acceptance-manifest.yml'
run 'git checkout metadata/saml20-sp-remote.php'

