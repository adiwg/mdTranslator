# coding: utf-8
# History
#  Stan Smith 2017-05-16 remove rgeo 0.5 support
#  Stan Smith 2019-03-19 migrated to version 2 bundler

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'adiwg/mdtranslator/version'

Gem::Specification.new do |spec|
   spec.name = "adiwg-mdtranslator"
   spec.version = ADIWG::Mdtranslator::VERSION
   spec.authors = ["Stan Smith", "Josh Bradley"]
   spec.email = ["stansmith@usgs.gov", "joshua_bradley@fws.gov"]
   spec.summary = %q{The mdtranslator (metadata translator) is a tool for translating metadata in one format to another. The tool is written and maintained by the Alaska Data Integration Working Group (ADIwg).}
   spec.description = %q{The mdtranslator was written by the Alaska Data Integration Working Group (ADIwg) to assist with creating ISO 19139 metadata records.  Input to the mdtranslator is JSON conforming to the mdJson-schema.  The mdtranslator architecture allows developers to write additional readers for other input formats and/or write additional writers for other output other than ISO 19139.}
   spec.homepage = "http://www.adiwg.org/mdTranslator"
   spec.license = "UNLICENSED"

   spec.files = %x(git ls-files).split($/).delete_if {|f| /^test*/.match(f)}
   spec.executables = spec.files.grep(%r{^bin/}) {|f| File.basename(f)}
   spec.test_files = spec.files.grep(%r{^(tc|test|spec|features)/})
   spec.require_paths = ["lib"]

   spec.required_ruby_version = '>= 2.3'

   spec.add_development_dependency "bundler", "~> 2"
   spec.add_development_dependency "rake", "~> 10"
   spec.add_development_dependency "minitest", "~> 5"

   spec.add_runtime_dependency "json", "~> 2.0"
   spec.add_runtime_dependency "builder", "~> 3.2"
   spec.add_runtime_dependency "thor", "~> 0.19"
   spec.add_runtime_dependency "uuidtools", "~> 2.1"
   spec.add_runtime_dependency "json-schema", "~> 2.7"
   spec.add_runtime_dependency "adiwg-mdjson_schemas", "2.8.0.pre.beta"
   spec.add_runtime_dependency "adiwg-mdcodes", "~> 2.8"
   spec.add_runtime_dependency "jbuilder", "~> 2.5"
   spec.add_runtime_dependency "kramdown", "~> 1.13"
   spec.add_runtime_dependency "coderay", "~> 1.1"
   spec.add_runtime_dependency "nokogiri", "~> 1.7"

end
