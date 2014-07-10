# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mdtranslator/version'

Gem::Specification.new do |spec|
  spec.name          = "mdtranslator"
  spec.version       = Mdtranslator::VERSION
  spec.authors       = ["stansmith907", "arcticlccjosh"]
  spec.email         = ["stansmith@usgs.gov", "joshua_bradley@fws.gov"]
  spec.summary       = %q{The mdtranslator (metadata translator) is a toolkit for translating metadata in one format to another. The toolkit is written and maintained by the Alaska Data Integration Working Group (ADIwg).}
  spec.description   = %q{The mdtranslator was written by the Alaska Data Integration Working Group (ADIwg) to assist users prepare ISO 19115-2 metadata records.  Input to the mdtranslator is simple JSON using the adiwg-json-schema.  The mdtranslator architecture allows developers to write additional readers for other input formats and/or write additional writers for other output other than ISO 19115-2.}
  spec.homepage      = "http://www.adiwg.org/mdTranslator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "builder"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "uuidtools"
end
