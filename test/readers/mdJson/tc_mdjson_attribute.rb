# MdTranslator - minitest of
# reader / mdJson / module_attributeGroup

# History:
#  Stan Smith 2018-06-15 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-18 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_attribute'

class TestReaderMdJsonAttribute < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Attribute

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.attribute

   @@mdHash = mdHash

   def test_attribute_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'attribute.json')
      assert_empty errors

   end

   def test_complete_attribute_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'sequence identifier name', metadata[:sequenceIdentifier]
      assert_equal 'sequence identifier type', metadata[:sequenceIdentifierType]
      assert_equal 'attribute description', metadata[:attributeDescription]
      assert_equal 2, metadata[:attributeIdentifiers].length
      assert_equal 0, metadata[:minValue]
      assert_equal 9, metadata[:maxValue]
      assert_equal 'min/max units', metadata[:units]
      assert_equal 99.9, metadata[:scaleFactor]
      assert_equal 1.0, metadata[:offset]
      assert_equal 50.0, metadata[:meanValue]
      assert_equal 9, metadata[:numberOfValues]
      assert_equal 9.9, metadata[:standardDeviation]
      assert_equal 9, metadata[:bitsPerValue]
      assert_equal 100, metadata[:boundMin]
      assert_equal 999, metadata[:boundMax]
      assert_equal 'bound min/max units', metadata[:boundUnits]
      assert_equal 99.9, metadata[:peakResponse]
      assert_equal 9, metadata[:toneGradations]
      assert_equal 'oneOverE', metadata[:bandBoundaryDefinition]
      assert_equal 99, metadata[:nominalSpatialResolution]
      assert_equal 'linear', metadata[:transferFunctionType]
      assert_equal 'leftCircular', metadata[:transmittedPolarization]
      assert_equal 'rightCircular', metadata[:detectedPolarization]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_attribute_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['sequenceIdentifier'] = ''
      hIn['sequenceIdentifierType'] = ''
      hIn['attributeDescription'] = ''
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
      hIn['nominalSpatialResolution'] = ''
      hIn['transferFunctionType'] = ''
      hIn['transmittedPolarization'] = ''
      hIn['detectedPolarization'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:sequenceIdentifier]
      assert_nil metadata[:sequenceIdentifierType]
      assert_nil metadata[:attributeDescription]
      assert_empty metadata[:attributeIdentifiers]
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
      assert_nil metadata[:nominalSpatialResolution]
      assert_nil metadata[:transferFunctionType]
      assert_nil metadata[:transmittedPolarization]
      assert_nil metadata[:detectedPolarization]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_attribute_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('sequenceIdentifier')
      hIn.delete('sequenceIdentifierType')
      hIn.delete('attributeDescription')
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
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:sequenceIdentifier]
      assert_nil metadata[:sequenceIdentifierType]
      assert_nil metadata[:attributeDescription]
      assert_empty metadata[:attributeIdentifiers]
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
      assert_nil metadata[:nominalSpatialResolution]
      assert_nil metadata[:transferFunctionType]
      assert_nil metadata[:transmittedPolarization]
      assert_nil metadata[:detectedPolarization]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_attribute_empty_units

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['units'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute units are missing: CONTEXT is testing'

   end

   def test_attribute_missing_units

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('units')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute units are missing: CONTEXT is testing'

   end

   def test_attribute_empty_boundUnits

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['boundUnits'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute bounds units are missing: CONTEXT is testing'

   end

   def test_attribute_missing_boundUnits

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('boundUnits')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute bounds units are missing: CONTEXT is testing'

   end

   def test_attribute_empty_sequenceIdentifierType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['sequenceIdentifierType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute sequence identifierType is missing: CONTEXT is testing'

   end

   def test_attribute_missing_sequenceIdentifierType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('sequenceIdentifierType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: attribute sequence identifierType is missing: CONTEXT is testing'

   end

   def test_empty_attribute_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: attribute object is empty: CONTEXT is testing'

   end

end
