#!/usr/bin/env ruby

$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib/')
require 'messagebird'

ACCESS_KEY = 'pWwN1qi9DXrQvKDmDyp0avDFJ'
VERIFY_ID  = 'a06e99d14d75433faacfd1206a3dd1ce'
TOKEN      = '12345'

unless defined?(ACCESS_KEY)
  puts 'You need to set an ACCESS_KEY constant in this file'
  exit 1
end

unless defined?(VERIFY_ID)
  puts 'You need to set an VERIFY_ID constant in this file'
  exit 1
end

unless defined?(TOKEN)
  puts 'You need to set an TOKEN constant in this file'
  exit 1
end

begin
  # Create a MessageBird client with the specified ACCESS_KEY.
  client = MessageBird::Client.new(ACCESS_KEY)

  # Verify an OTP message with a token
  otp = client.verify_token(VERIFY_ID, TOKEN)

  # Print the object information.
  puts
  puts "The following information was returned as an OTP object:"
  puts
  puts "  id                  : #{otp.id}"
  puts "  recipient           : #{otp.recipient}"
  puts "  reference           : #{otp.reference}"
  puts "  status              : #{otp.status}"
  puts "  href                : #{otp.href}"
  puts "  createdDatetime     : #{otp.createdDatetime}"
  puts "  validUntilDatetime  : #{otp.validUntilDatetime}"
  puts

rescue MessageBird::ErrorException => ex
  puts
  puts 'An error occured while requesting an OTP object:'
  puts

  ex.errors.each do |error|
    puts "  code        : #{error.code}"
    puts "  description : #{error.description}"
    puts "  parameter   : #{error.parameter}"
    puts
  end
end