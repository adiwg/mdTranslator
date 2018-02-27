# MdTranslator - minitest of
# reader / mdJson / module_geographicResolution

# History:
#   Stan Smith 2017-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicResolution'

class TestReaderMdJsonGeographicResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicResolution
   aIn = TestReaderMdJsonParent.getJson('geographicResolution.json')
   @@hIn = aIn['spatialResolution'][0]['geographicResolution']

   # TODO reinstate after schema update
   # def test_geographicResolution_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'measure.json')
   #     assert_empty errors
   #
   # end

   def test_complete_geoRes

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9.9, metadata[:latitudeResolution]
      assert_equal 99.9, metadata[:longitudeResolution]
      assert_equal 'geographic resolution UOM', metadata[:unitOfMeasure]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geoRes_empty_latitudeResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['latitudeResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution latitude resolution is missing'

   end

   def test_complete_geoRes_missing_latitudeResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('latitudeResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution latitude resolution is missing'

   end

   def test_complete_geoRes_empty_longitudeResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['longitudeResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution longitude resolution is missing'

   end

   def test_complete_geoRes_missing_longitudeResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('longitudeResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution longitude resolution is missing'

   end

   def test_complete_geoRes_empty_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['unitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution units are missing'

   end

   def test_complete_geoRes_missing_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('unitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution units are missing'

   end

   def test_empty_geoRes_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic spatial resolution object is empty'

   end

end
