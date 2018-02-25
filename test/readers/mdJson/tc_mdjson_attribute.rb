# MdTranslator - minitest of
# reader / mdJson / module_attributeGroup

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-18 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_attribute'

class TestReaderMdJsonAttribute < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Attribute
   aIn = TestReaderMdJsonParent.getJson('attribute.json')
   @@hIn = aIn['attribute'][0]

   def test_attribute_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'attribute.json')
      assert_empty errors

   end

   def test_complete_attribute_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'sequenceIdentifier', metadata[:sequenceIdentifier]
      assert_equal 'sequenceIdentifierType', metadata[:sequenceIdentifierType]
      assert_equal 'attributeDescription', metadata[:attributeDescription]
      refute_empty metadata[:attributeIdentifiers]
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
      assert_equal 9.9, metadata[:nominalSpatialResolution]
      assert_equal 'transferFunctionType', metadata[:transferFunctionType]
      assert_equal 'transmittedPolarization', metadata[:transmittedPolarization]
      assert_equal 'detectedPolarization', metadata[:detectedPolarization]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_attribute_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
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
      metadata = @@NameSpace.unpack(hIn, hResponse)

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

      hIn = Marshal::load(Marshal.dump(@@hIn))
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
      metadata = @@NameSpace.unpack(hIn, hResponse)

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

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['units'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute units are missing'

   end

   def test_attribute_missing_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('units')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute units are missing'

   end

   def test_attribute_empty_boundUnits

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['boundUnits'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute bound units are missing'

   end

   def test_attribute_missing_boundUnits

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('boundUnits')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute bound units are missing'

   end

   def test_attribute_empty_sequenceIdentifierType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['sequenceIdentifierType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute sequence identifierType is missing'

   end

   def test_attribute_missing_sequenceIdentifierType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('sequenceIdentifierType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson coverage description attribute sequence identifierType is missing'

   end

   def test_empty_attribute_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson coverage description attribute object is empty'

   end

end
