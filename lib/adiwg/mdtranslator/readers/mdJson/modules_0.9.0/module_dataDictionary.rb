# unpack a data dictionary
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-12-01 original script

require ADIWG::Mdtranslator.reader_module('module_dictionaryInfo', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_domain', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_entity', $response[:readerVersionUsed])

module Md_DataDictionary

	def self.unpack(hDictionary)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDict = intMetadataClass.newDataDictionary

		unless hDictionary.empty?

			# data dictionary - dictionary information
			if hDictionary.has_key?('dictionaryInfo')
				hDictInfo = hDictionary['dictionaryInfo']
				intDict[:dictionaryInfo] = Md_DictionaryInfo.unpack(hDictInfo)
			end

			# data dictionary - domains
			if hDictionary.has_key?('domain')
				aDomains = hDictionary['domain']
				aDomains.each do |hDomain|
					unless hDomain.empty?
						intDict[:domains] << Md_Domain.unpack(hDomain)
					end
				end
			end

			# data dictionary - entity
			if hDictionary.has_key?('entity')
				aEntities = hDictionary['entity']
				aEntities.each do |hEntity|
					unless hEntity.empty?
						intDict[:entities] << Md_Entity.unpack(hEntity)
					end
				end
			end

		return intDict

		end

	end

end