# unpack a data dictionary domain item
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script

module Md_DomainItem

	def self.unpack(hDoItem)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intItem = intMetadataClass.newDomainItem

		# data dictionary domain item - name
		if hDoItem.has_key?('name')
			s = hDoItem['name']
			if s != ''
				intItem[:itemName] = s
			end
		end

		# data dictionary domain item - value
		if hDoItem.has_key?('value')
			s = hDoItem['value']
			if s != ''
				intItem[:itemValue] = s
			end
		end

		# data dictionary domain item - definition
		if hDoItem.has_key?('definition')
			s = hDoItem['definition']
			if s != ''
				intItem[:itemDefinition] = s
			end
		end

		return intItem
	end

end
