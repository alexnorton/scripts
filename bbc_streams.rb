#!/usr/bin/env ruby

services = [
  { name: 'BBC One London',       sid: 'bbc_one_london' },
  { name: 'BBC One HD',           sid: 'bbc_one_hd' },
  { name: 'BBC Two England',      sid: 'bbc_two_england' },
  { name: 'BBC Two HD',           sid: 'bbc_two_hd' },
  { name: 'BBC Three',            sid: 'bbc_three' },
  { name: 'BBC Three HD',         sid: 'bbc_three_hd' },
  { name: 'BBC Four',             sid: 'bbc_four' },
  { name: 'BBC Four HD',          sid: 'bbc_four_hd' },
  { name: 'BBC News Channel',     sid: 'bbc_news24' },
  { name: 'BBC News Channel HD',  sid: 'bbc_news_channel_hd' },  
]

cdns = ['ak', 'llnw']

while true

  puts "Available services:"

  services.each_with_index do |service, index|
    puts " #{index + 1}) #{service[:name]}"
  end

  puts "\nPlease choose a service, or 'q' to exit:"

  input = gets

  break if input.chomp == 'q'

  service_no = input.to_i - 1
  
  if service_no > 0 and service_no < services.length
    service = services[service_no]

    cdn = cdns.sample

    system("livestreamer hds://a.files.bbci.co.uk/media/live/manifesto/audio_video/simulcast/hds/uk/pc/#{cdn}/#{service[:sid]}.f4m best")
  end
  
end