#!/usr/bin/env ruby

require 'uri'

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

puts 'We need to know the locations of your Ops Manager and BOSH director UAAs...'
opsman_url = prompt "What is the scheme, host and port of your Ops Manager's UAA? (default is 'http://localhost:8080') "
opsman_url = 'http://localhost:8080' if opsman_url.empty?
bosh_url = prompt "What is the scheme, host and port of your BOSH director's UAA? (usually 'https://DIRECTOR_IP:8443'). Leave this empty if the director has not been deployed yet. "

opsman_entity_id = opsman_url + '/uaa'
bosh_entity_id = bosh_url

opsman_entity_alias = URI(opsman_url).host
bosh_entity_alias = URI(bosh_url).host

opsman_metadata = <<-PHP
$metadata['#{opsman_entity_id}'] = array(
    'AssertionConsumerService' => '#{opsman_url}/uaa/saml/SSO/alias/#{opsman_entity_alias}',
    'SingleLogoutService' => '#{opsman_url}/uaa/saml/SingleLogout/alias/#{opsman_entity_alias}',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
PHP

bosh_metadata = <<-PHP
$metadata['#{bosh_entity_id}'] = array(
    'AssertionConsumerService' => '#{bosh_url}/saml/SSO/alias/#{bosh_entity_alias}',
    'SingleLogoutService' => '#{bosh_url}/saml/SingleLogout/alias/#{bosh_entity_alias}',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    'simplesaml.nameidattribute' => 'emailAddress',
);
PHP

metadata_file = '<?php' + "\n\n" + opsman_metadata + "\n\n"
metadata_file += bosh_metadata unless bosh_url.empty?

File.write('metadata/saml20-sp-remote.php', metadata_file)

name = prompt 'App name on PWS: '
if name.length == 0
  puts 'Aborting.'
  run 'git checkout metadata/saml20-sp-remote.php'
  exit
end

prompt "Hit ENTER to cf push #{name}. "

run "cf push #{name} -n #{name} -m 128M -b https://github.com/cf-identity/php-buildpack.git"
run 'git checkout metadata/saml20-sp-remote.php'
