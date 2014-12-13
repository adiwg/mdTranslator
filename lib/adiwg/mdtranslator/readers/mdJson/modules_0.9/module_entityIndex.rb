# unpack an data entity index
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script

module Md_EntityIndex

	def self.unpack(hIndex)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intIndex = intMetadataClass.newEntityIndex

		# entity index - code name
		if hIndex.has_key?('codeName')
			s = hIndex['codeName']
			if s != ''
				intIndex[:indexCode] = s
			end
		end

		# entity index - allow duplicates
		if hIndex.has_key?('allowDuplicates')
			s = hIndex['allowDuplicates']
			if s != ''
				intIndex[:duplicate] = s
			end
		end

		# entity index - attribute list
		if hIndex.has_key?('attributeCodeName')
			aKeyAttributes = hIndex['attributeCodeName']
			unless aKeyAttributes.empty?
				intIndex[:attributeNames] = aKeyAttributes
			end
		end

		return intIndex
	end

end
