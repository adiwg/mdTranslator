# adiwg mdTranslator

# version history

# 0.8.0 2014-09-26 first version to release
# 0.8.1 2014-10-06 used uri from first onlineResource of the resource citation
#              ... as source for datasetURI in iso19115-2 writer
#              ... removed resourceURI from resourceInfo section of adiwgJson
# 0.8.2 2014-10-09 added the 'version' command to the CLI for returning the
#              ... mdTranslator version number
# 0.8.3 2014-10-10 added readme files for each reader and writer
#              ... the readme files are used as the content for api web pages
# 0.8.4 2014-10-10 modified to pass minimum metadata input test
#              ... test were added to handle a missing metadata > metadataInfo
#              ... block in the input.

module ADIWG
	module Mdtranslator
		# current mdtranslator version
		VERSION = "0.8.4"
	end
end

