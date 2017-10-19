# MdTranslator - minitest of
# reader / mdJson / module_bearingDistanceResolution

# History:
#   Stan Smith 2017-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_coordinateResolution'

class TestReaderMdJsonBearingDistanceResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BearingDistanceResolution
   aIn = TestReaderMdJsonParent.getJson('bearingDistanceResolution.json')
   @@hIn = aIn['spatialResolution'][0]['bearingDistanceResolution']

   # TODO reinstate after schema update
   # def test_coordinateResolution_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'measure.json')
   #     assert_empty errors
   #
   # end

   def test_complete_bearingDistanceResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9.9, metadata[:distanceResolution]
      assert_equal 'distance UOM', metadata[:distanceUnitOfMeasure]
      assert_equal 99.9, metadata[:bearingResolution]
      assert_equal 'bearing UOM', metadata[:bearingUnitOfMeasure]
      assert_equal 'north', metadata[:bearingReferenceDirection]
      assert_equal 'assumed', metadata[:bearingReferenceMeridian]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_distanceResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['distanceResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_distanceResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('distanceResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_distanceUOM

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['distanceUnitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_distanceUOM

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('distanceUnitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_bearingResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['bearingResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_bearingResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('bearingResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_bearingUnitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['bearingUnitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_bearingUnitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('bearingUnitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_bearingReferenceDirection

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['bearingReferenceDirection'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_bearingReferenceDirection

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('bearingReferenceDirection')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_empty_bearingReferenceMeridian

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['bearingReferenceMeridian'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bearingDistanceResolution_missing_bearingReferenceMeridian

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('bearingReferenceMeridian')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_bearingDistanceResolution_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
