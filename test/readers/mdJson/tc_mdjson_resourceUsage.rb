# MdTranslator - minitest of
# reader / mdJson / module_resourceUsage

# History:
#   Stan Smith 2016-10-11 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceUsage'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
                module MdJson

                    # create new internal metadata container for the reader
                    intMetadataClass = InternalMetadata.new
                    intObj = intMetadataClass.newBase

                    # first contact
                    intObj[:contacts] << intMetadataClass.newContact
                    intObj[:contacts][0][:contactId] = 'individualId0'
                    intObj[:contacts][0][:isOrganization] = false

                    # second contact
                    intObj[:contacts] << intMetadataClass.newContact
                    intObj[:contacts][1][:contactId] = 'individualId1'
                    intObj[:contacts][1][:isOrganization] = false

                    @contacts = intObj[:contacts]

                end
            end
        end
    end
end

class TestReaderMdJsonResourceUsage < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceUsage
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'usage.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['resourceUsage'][0]

    def test_complete_resourceUsage_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_equal 'userDeterminedLimitation', metadata[:userLimitation]
        assert_equal 2, metadata[:limitationResponses].length
        assert_equal 'limitationResponse0', metadata[:limitationResponses][0]
        assert_equal 'limitationResponse1', metadata[:limitationResponses][1]
        assert_equal 2, metadata[:userContacts].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_empty_specificUsage

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['specificUsage'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_missing_specificUsage

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('specificUsage')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['userDeterminedLimitation'] = ''
        hIn['limitationResponse'] = []
        hIn['userContactInfo'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_nil metadata[:userLimitation]
        assert_empty metadata[:limitationResponses]
        assert_empty metadata[:userContacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_resourceUsage_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('userDeterminedLimitation')
        hIn.delete('limitationResponse')
        hIn.delete('userContactInfo')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specificUsage', metadata[:specificUsage]
        assert_nil metadata[:userLimitation]
        assert_empty metadata[:limitationResponses]
        assert_empty metadata[:userContacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceUsage_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
