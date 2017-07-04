# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shamsi/version'

Gem::Specification.new do |spec|
  spec.name          = 'shamsi'
  spec.version       = Shamsi::VERSION
  spec.authors       = ['Seyyed Mohammad Borghei']
  spec.email         = ['borghei71@gmail.com']

  spec.summary       = 'Persian Date & Time library'
  spec.description   = 'A Persian Date & Time (aka: Jalali Calendar) library with timezone, DST (daylight-saving), full formatting & parsing support'
  spec.homepage      = 'https://github.com/memlucky71/shamsi'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
