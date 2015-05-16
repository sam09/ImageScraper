# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ImageScraper/version'

Gem::Specification.new do |spec|
  spec.name          = "ImageScraper"
  spec.version       = ImageScraper::VERSION
  spec.authors       = ["Sam Radhakrishnan"]
  spec.email         = ["sk09idm@gmail.com"]
  spec.summary       = %q{A gem to download images from url}
  spec.description   = %q{A gem to download all the images at a particular URL}
  spec.homepage      = "https://github.com/sam09/ImageScraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "open-uri"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "rubygems"
end
