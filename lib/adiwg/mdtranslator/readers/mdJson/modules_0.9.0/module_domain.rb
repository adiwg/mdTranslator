# unpack a data dictionary domain
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script

require ADIWG::Mdtranslator.reader_module('module_domainItem', $response[:readerVersionUsed])

module Adiwg_Domain

	def self.unpack(hDomain)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDomain = intMetadataClass.newDictionaryDomain

		# data dictionary domain - id
		if hDomain.has_key?('domainId')
			s = hDomain['domainId']
			if s != ''
				intDomain[:domainId] = s
			end
		end

		# data dictionary domain - name
		if hDomain.has_key?('commonName')
			s = hDomain['commonName']
			if s != ''
				intDomain[:domainName] = s
			end
		end

		# data dictionary domain - code
		if hDomain.has_key?('codeName')
			s = hDomain['codeName']
			if s != ''
				intDomain[:domainCode] = s
			end
		end

		# data dictionary domain - description
		if hDomain.has_key?('description')
			s = hDomain['description']
			if s != ''
				intDomain[:domainDescription] = s
			end
		end

		# data dictionary domain - members
		if hDomain.has_key?('member')
			aDoItems = hDomain['member']
			aDoItems.each do |hDoItem|
				unless hDoItem.empty?
					intDomain[:domainItems] << Adiwg_DomainItem.unpack(hDoItem)
				end
			end
		end

		return intDomain
	end

end
