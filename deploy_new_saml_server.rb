#!/usr/bin/env ruby

def self.run(cmd)
  system(cmd) or raise "Failed to run #{cmd}"
end

def prompt(string)
  print string
  STDOUT.flush
  gets.strip
end

puts
puts "Welcome #{`whoami`.strip}! Please make sure you have cf setup and logged in."
puts

opsman_ip = prompt "What IP or hostname (with https and port) would you like this SAML server to accept traffic from? "
bosh_ip = prompt "What IP or hostname (with https and port) would you like this SAML server to accept BOSH director traffic from? Leave this empty if the director has not been deployed yet. "

opsman_metadata = <<-PHP
$metadata['opsman-login'] = array(
    'AssertionConsumerService' => '#{opsman_ip}/uaa/saml/SSO/alias/opsman-login',
    'SingleLogoutService' => '#{opsman_ip}/uaa/saml/SSO/alias/opsman-login',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
PHP

bosh_metadata = <<-PHP
$metadata['bosh-uaa'] = array(
    'AssertionConsumerService' => '#{bosh_ip}:8443/saml/SSO/alias/bosh-uaa',
    'SingleLogoutService' => '#{bosh_ip}:8443/saml/SSO/alias/bosh-uaa',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
PHP

metadata_file = '<?php' + "\n\n" + opsman_metadata + "\n\n"
metadata_file += bosh_metadata unless bosh_ip.empty?

File.write('metadata/saml20-sp-remote.php', metadata_file)

name = prompt "What name should this be pushed to pws as: "
if name.length == 0
  puts "Aborting."
  run 'git checkout metadata/saml20-sp-remote.php'
  exit
end

prompt "Hit return to cf push #{name} to your default space and credentials. "

run "cf push #{name} -n #{name} -m 128M -b https://github.com/cf-identity/php-buildpack.git"
run 'git checkout metadata/saml20-sp-remote.php'

