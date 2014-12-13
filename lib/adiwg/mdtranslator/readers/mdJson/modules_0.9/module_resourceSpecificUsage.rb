# unpack resource specific usage
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-25 original script
# 	Stan Smith 2013-11-27 modified to process a single resource usage
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $response[:readerVersionUsed])

module Md_ResourceSpecificUsage

    def self.unpack(hUsage)

        # instance classes needed in script
        intMetadataClass = InternalMetadata.new
        intUsage = intMetadataClass.newDataUsage

        # resource specific usage - specific usage
        if hUsage.has_key?('specificUsage')
            s = hUsage['specificUsage']
            if s != ''
                intUsage[:specificUsage] = s
            end
        end

        # resource specific usage - user determined limitations
        if hUsage.has_key?('userDeterminedLimitation')
            s = hUsage['userDeterminedLimitation']
            if s != ''
                intUsage[:userLimits] = s
            end
        end

        # taxonomy - repository - responsible party
        if hUsage.has_key?('userContactInfo')
            aContacts = hUsage['userContactInfo']
            unless aContacts.empty?
                aContacts.each do |hContact|
                    intUsage[:userContacts] << Md_ResponsibleParty.unpack(hContact)
                end
            end
        end

        return intUsage

    end

end
