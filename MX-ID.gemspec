# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MX/ID/version'

Gem::Specification.new do |spec|
  spec.name          = "MX-ID"
  spec.version       = MX::ID::VERSION # `git describe --tags --abbrev=0`.strip
  spec.authors       = ["Pablo Ruiz"]
  spec.email         = ["pjruiz@maquech.com.mx"]
  spec.summary       = %q{Mexican government identifiers utilities / Utilerías para identifcadores del gobierno mexicano}
  spec.description   = %q{Mexican government identifiers utilities / Utilerías para identifcadores del gobierno mexicano}
  spec.homepage      = "https://github.com/Maquech/MX-ID"
  spec.license       = "MIT"
  spec.post_install_message = "¡Viva México!"

  spec.required_ruby_version = '>= 1.9.3'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'activesupport'
  spec.add_dependency 'numbers_and_words'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency 'terminal-notifier' # OS X
  spec.add_development_dependency 'terminal-notifier-guard' # OS X
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "coveralls"
  
  # Docs
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'github-markup'
  spec.add_development_dependency "yard", ">= 0.8"
end
