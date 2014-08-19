# unpack browse graphic
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-10-17 original script
# 	Stan Smith 2013-11-27 modified to process single browse graphic rather than array
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
#   Stan Smith 2014-08-18 changed graphic link from uri to url schema 0.6.0

module Adiwg_BrowseGraphic

	def self.unpack(hBgraphic)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intBGraphic = intMetadataClass.newBrowseGraphic

		# graphic - file name
		if hBgraphic.has_key?('fileName')
			s = hBgraphic['fileName']
			if s != ''
				intBGraphic[:bGName] = s
			end
		end

		# graphic - file description
		if hBgraphic.has_key?('fileDescription')
			s = hBgraphic['fileDescription']
			if s != ''
				intBGraphic[:bGDescription] = s
			end
		end

		# graphic - file  type
		if hBgraphic.has_key?('fileType')
			s = hBgraphic['fileType']
			if s != ''
				intBGraphic[:bGType] = s
			end
		end

		# graphic - web link
		if hBgraphic.has_key?('fileLink')
			s = hBgraphic['fileLink']
			if s != ''
				intBGraphic[:bGURL] = s
			end
		end

		return intBGraphic
	end

end