# MdTranslator - minitest of
# reader / mdJson / module_resourceInfo

# History:
#   Stan Smith 2016-11-01 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceInfo'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                # create new internal metadata container for the reader
                intMetadataClass = InternalMetadata.new
                @intObj = intMetadataClass.newBase

                # first contact
                @intObj[:contacts] << intMetadataClass.newContact
                @intObj[:contacts][0][:contactId] = 'individualId0'
                @intObj[:contacts][0][:isOrganization] = false

            end
        end
    end
end

class TestReaderMdJsonResourceInfo < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceInfo
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'resourceInfo.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['resourceInfo'][0]

    def test_complete_resourceInfo_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'resourceType', metadata[:resourceType]
        refute_empty metadata[:citation]
        assert_equal 'abstract', metadata[:abstract]
        assert_equal 'shortAbstract', metadata[:shortAbstract]
        assert_equal 'purpose', metadata[:purpose]
        assert_equal 2, metadata[:credits].length
        refute_empty metadata[:timePeriod]
        assert_equal 2, metadata[:status].length
        assert_equal 2, metadata[:topicCategories].length
        assert_equal 2, metadata[:pointOfContacts].length
        assert_equal 2, metadata[:spatialReferenceSystems].length
        assert_equal 2, metadata[:spatialRepresentationTypes].length
        assert_equal 2, metadata[:spatialRepresentations].length
        assert_equal 2, metadata[:spatialResolutions].length
        assert_equal 2, metadata[:temporalResolutions].length
        assert_equal 2, metadata[:extents].length
        assert_equal 2, metadata[:contentInfo].length
        refute_empty metadata[:taxonomy]
        assert_equal 2, metadata[:graphicOverviews].length
        assert_equal 2, metadata[:resourceFormats].length
        assert_equal 2, metadata[:keywords].length
        assert_equal 2, metadata[:resourceUsages].length
        assert_equal 2, metadata[:constraints].length
        refute_empty metadata[:defaultResourceLocale]
        assert_equal 2, metadata[:otherResourceLocales].length
        assert_equal 2, metadata[:resourceMaintenance].length
        assert_equal 'environmentDescription', metadata[:environmentDescription]
        assert_equal 'supplementalInfo', metadata[:supplementalInfo]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['citation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('citation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_abstract

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['abstract'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_abstract

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('abstract')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['pointOfContact'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('pointOfContact')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_locale

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['defaultResourceLocale'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_locale

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('defaultResourceLocale')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_resourceInfo_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['shortAbstract'] = ''
        hIn['purpose'] = ''
        hIn['credits'] = []
        hIn['timePeriod'] = {}
        hIn['purpose'] = ''
        hIn['status'] = []
        hIn['topicCategory'] = []
        hIn['spatialReferenceSystem'] = []
        hIn['spatialRepresentationType'] = []
        hIn['spatialRepresentation'] = []
        hIn['spatialResolution'] = []
        hIn['temporalResolution'] = []
        hIn['extent'] = []
        hIn['contentInfo'] = []
        hIn['taxonomy'] = {}
        hIn['graphicOverview'] = []
        hIn['resourceFormat'] = []
        hIn['keyword'] = []
        hIn['resourceUsage'] = []
        hIn['constraint'] = []
        hIn['otherResourceLocale'] = []
        hIn['resourceMaintenance'] = []
        hIn['environmentDescription'] = ''
        hIn['supplementalInfo'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'resourceType', metadata[:resourceType]
        refute_empty metadata[:citation]
        assert_equal 'abstract', metadata[:abstract]
        assert_nil metadata[:shortAbstract]
        assert_nil metadata[:purpose]
        assert_empty metadata[:credits]
        assert_empty metadata[:timePeriod]
        assert_empty metadata[:status]
        assert_empty metadata[:topicCategories]
        refute_empty metadata[:pointOfContacts]
        assert_empty metadata[:spatialReferenceSystems]
        assert_empty metadata[:spatialRepresentationTypes]
        assert_empty metadata[:spatialRepresentations]
        assert_empty metadata[:spatialResolutions]
        assert_empty metadata[:temporalResolutions]
        assert_empty metadata[:extents]
        assert_empty metadata[:contentInfo]
        assert_empty metadata[:taxonomy]
        assert_empty metadata[:graphicOverviews]
        assert_empty metadata[:resourceFormats]
        assert_empty metadata[:keywords]
        assert_empty metadata[:resourceUsages]
        assert_empty metadata[:constraints]
        refute_empty metadata[:defaultResourceLocale]
        assert_empty metadata[:otherResourceLocales]
        assert_empty metadata[:resourceMaintenance]
        assert_nil metadata[:environmentDescription]
        assert_nil metadata[:supplementalInfo]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_resourceInfo_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('shortAbstract')
        hIn.delete('purpose')
        hIn.delete('credits')
        hIn.delete('timePeriod')
        hIn.delete('purpose')
        hIn.delete('status')
        hIn.delete('topicCategory')
        hIn.delete('spatialReferenceSystem')
        hIn.delete('spatialRepresentationType')
        hIn.delete('spatialRepresentation')
        hIn.delete('spatialResolution')
        hIn.delete('temporalResolution')
        hIn.delete('extent')
        hIn.delete('contentInfo')
        hIn.delete('taxonomy')
        hIn.delete('graphicOverview')
        hIn.delete('resourceFormat')
        hIn.delete('keyword')
        hIn.delete('resourceUsage')
        hIn.delete('constraint')
        hIn.delete('otherResourceLocale')
        hIn.delete('resourceMaintenance')
        hIn.delete('environmentDescription')
        hIn.delete('supplementalInfo')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'resourceType', metadata[:resourceType]
        refute_empty metadata[:citation]
        assert_equal 'abstract', metadata[:abstract]
        assert_nil metadata[:shortAbstract]
        assert_nil metadata[:purpose]
        assert_empty metadata[:credits]
        assert_empty metadata[:timePeriod]
        assert_empty metadata[:status]
        assert_empty metadata[:topicCategories]
        refute_empty metadata[:pointOfContacts]
        assert_empty metadata[:spatialReferenceSystems]
        assert_empty metadata[:spatialRepresentationTypes]
        assert_empty metadata[:spatialRepresentations]
        assert_empty metadata[:spatialResolutions]
        assert_empty metadata[:temporalResolutions]
        assert_empty metadata[:extents]
        assert_empty metadata[:contentInfo]
        assert_empty metadata[:taxonomy]
        assert_empty metadata[:graphicOverviews]
        assert_empty metadata[:resourceFormats]
        assert_empty metadata[:keywords]
        assert_empty metadata[:resourceUsages]
        assert_empty metadata[:constraints]
        refute_empty metadata[:defaultResourceLocale]
        assert_empty metadata[:otherResourceLocales]
        assert_empty metadata[:resourceMaintenance]
        assert_nil metadata[:environmentDescription]
        assert_nil metadata[:supplementalInfo]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_resourceInfo_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
