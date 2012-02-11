#!/usr/bin/env ruby

require 'rubygems'
require 'anemone'
require 'mongo'

file = File.new("mapa_site.txt","w")
Anemone.crawl("http://www.domain.com", :discard_page_bodies => true) do |anemone|
    anemone.storage = Anemone::Storage.Redis
    anemone.on_every_page do |page|
	file.puts page.url
    end
end
