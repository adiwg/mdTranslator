# MdTranslator - minitest of
# reader / mdJson / module_attributeGroup

# History:
#   Stan Smith 2016-10-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_attributeGroup'

class TestReaderMdJsonAttributeGroup < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AttributeGroup
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'attributeGroup.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['attributeGroup'][0]

    def test_complete_attributeGroup_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:attributeContentType].length
        assert_equal 'attributeContentType0', metadata[:attributeContentType][0]
        assert_equal 'attributeContentType1', metadata[:attributeContentType][1]
        assert_equal 'attributeDescription', metadata[:attributeDescription]
        assert_equal 'sequenceIdentifier', metadata[:sequenceIdentifier]
        assert_equal 'sequenceIdentifierType', metadata[:sequenceIdentifierType]
        refute_empty metadata[:attributeIdentifier]
        assert_equal 9.9, metadata[:minValue]
        assert_equal 9.9, metadata[:maxValue]
        assert_equal 'units', metadata[:units]
        assert_equal 999, metadata[:scaleFactor]
        assert_equal 999, metadata[:offset]
        assert_equal 9.9, metadata[:meanValue]
        assert_equal 999, metadata[:numberOfValues]
        assert_equal 9.9, metadata[:standardDeviation]
        assert_equal 999, metadata[:bitsPerValue]
        assert_equal 9.9, metadata[:boundMin]
        assert_equal 9.9, metadata[:boundMax]
        assert_equal 'boundUnits', metadata[:boundUnits]
        assert_equal 9.9, metadata[:peakResponse]
        assert_equal 999, metadata[:toneGradations]
        assert_equal 'bandBoundaryDefinition', metadata[:bandBoundaryDefinition]
        refute_empty metadata[:nominalSpatialResolution]
        assert_equal 'transferFunctionType', metadata[:transferFunctionType]
        assert_equal 'transmittedPolarization', metadata[:transmittedPolarization]
        assert_equal 'detectedPolarization', metadata[:detectedPolarization]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['attributeDescription'] = ''
        hIn['sequenceIdentifier'] = ''
        hIn['sequenceIdentifierType'] = ''
        hIn['attributeIdentifier'] = []
        hIn['minValue'] = ''
        hIn['maxValue'] = ''
        hIn['units'] = ''
        hIn['scaleFactor'] = ''
        hIn['offset'] = ''
        hIn['meanValue'] = ''
        hIn['numberOfValues'] = ''
        hIn['standardDeviation'] = ''
        hIn['bitsPerValue'] = ''
        hIn['boundMin'] = ''
        hIn['boundMax'] = ''
        hIn['boundUnits'] = ''
        hIn['peakResponse'] = ''
        hIn['toneGradations'] = ''
        hIn['bandBoundaryDefinition'] = ''
        hIn['nominalSpatialResolution'] = {}
        hIn['transferFunctionType'] = ''
        hIn['transmittedPolarization'] = ''
        hIn['detectedPolarization'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:attributeContentType]
        assert_nil metadata[:attributeDescription]
        assert_nil metadata[:sequenceIdentifier]
        assert_nil metadata[:sequenceIdentifierType]
        assert_empty metadata[:attributeIdentifier]
        assert_nil metadata[:minValue]
        assert_nil metadata[:maxValue]
        assert_nil metadata[:units]
        assert_nil metadata[:scaleFactor]
        assert_nil metadata[:offset]
        assert_nil metadata[:meanValue]
        assert_nil metadata[:numberOfValues]
        assert_nil metadata[:standardDeviation]
        assert_nil metadata[:bitsPerValue]
        assert_nil metadata[:boundMin]
        assert_nil metadata[:boundMax]
        assert_nil metadata[:boundUnits]
        assert_nil metadata[:peakResponse]
        assert_nil metadata[:toneGradations]
        assert_nil metadata[:bandBoundaryDefinition]
        assert_empty metadata[:nominalSpatialResolution]
        assert_nil metadata[:transferFunctionType]
        assert_nil metadata[:transmittedPolarization]
        assert_nil metadata[:detectedPolarization]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('attributeDescription')
        hIn.delete('sequenceIdentifier')
        hIn.delete('sequenceIdentifierType')
        hIn.delete('attributeIdentifier')
        hIn.delete('minValue')
        hIn.delete('maxValue')
        hIn.delete('units')
        hIn.delete('scaleFactor')
        hIn.delete('offset')
        hIn.delete('meanValue')
        hIn.delete('numberOfValues')
        hIn.delete('standardDeviation')
        hIn.delete('bitsPerValue')
        hIn.delete('boundMin')
        hIn.delete('boundMax')
        hIn.delete('boundUnits')
        hIn.delete('peakResponse')
        hIn.delete('toneGradations')
        hIn.delete('bandBoundaryDefinition')
        hIn.delete('nominalSpatialResolution')
        hIn.delete('transferFunctionType')
        hIn.delete('transmittedPolarization')
        hIn.delete('detectedPolarization')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:attributeContentType]
        assert_nil metadata[:attributeDescription]
        assert_nil metadata[:sequenceIdentifier]
        assert_nil metadata[:sequenceIdentifierType]
        assert_empty metadata[:attributeIdentifier]
        assert_nil metadata[:minValue]
        assert_nil metadata[:maxValue]
        assert_nil metadata[:units]
        assert_nil metadata[:scaleFactor]
        assert_nil metadata[:offset]
        assert_nil metadata[:meanValue]
        assert_nil metadata[:numberOfValues]
        assert_nil metadata[:standardDeviation]
        assert_nil metadata[:bitsPerValue]
        assert_nil metadata[:boundMin]
        assert_nil metadata[:boundMax]
        assert_nil metadata[:boundUnits]
        assert_nil metadata[:peakResponse]
        assert_nil metadata[:toneGradations]
        assert_nil metadata[:bandBoundaryDefinition]
        assert_empty metadata[:nominalSpatialResolution]
        assert_nil metadata[:transferFunctionType]
        assert_nil metadata[:transmittedPolarization]
        assert_nil metadata[:detectedPolarization]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_empty_contentType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['attributeContentType'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_contentType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('attributeContentType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_units

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['units'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_boundUnits

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['boundUnits'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_attributeGroup_missing_sequenceIdentifierType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['sequenceIdentifierType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_attributeGroup_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
