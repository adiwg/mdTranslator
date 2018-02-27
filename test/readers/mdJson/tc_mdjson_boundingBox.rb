# MdTranslator - minitest of
# reader / mdJson / module_boundingBox

# History:
#  Stan Smith 2017-09-28 add altitude to support fgdc
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-12-02 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_boundingBox'

class TestReaderMdJsonBoundingBox < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::BoundingBox
   aIn = TestReaderMdJsonParent.getJson('boundingBox.json')
   @@hIn = aIn['boundingBox'][0]

   # TODO reinstate after schema update
   # def test_boundingBox_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'geographicExtent.json', :fragment=>'boundingBox')
   #     assert_empty errors
   #
   # end

   def test_complete_boundingBox

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal -140, metadata[:westLongitude]
      assert_equal -120, metadata[:eastLongitude]
      assert_equal 49, metadata[:southLatitude]
      assert_equal 70, metadata[:northLatitude]
      assert_equal 250.0, metadata[:minimumAltitude]
      assert_equal 1500.0, metadata[:maximumAltitude]
      assert_equal 'meters', metadata[:unitsOfAltitude]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_boundingBox_empty_west

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['westLongitude'] = ''
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box west boundary is missing'

   end

   def test_boundingBox_empty_east

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['eastLongitude'] = ''
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box east boundary is missing'

   end

   def test_boundingBox_empty_south

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['southLatitude'] = ''
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box south boundary is missing'

   end

   def test_boundingBox_empty_north

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['northLatitude'] = ''
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box north boundary is missing'

   end

   def test_boundingBox_missing_west

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn.delete('westLongitude')
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box west boundary is missing'

   end

   def test_boundingBox_missing_east

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn.delete('eastLongitude')
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box east boundary is missing'

   end

   def test_boundingBox_missing_south

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn.delete('southLatitude')
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box south boundary is missing'

   end

   def test_boundingBox_missing_north

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn.delete('northLatitude')
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box north boundary is missing'

   end

   def test_boundingBox_west_outOfBounds

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['westLongitude'] = 200
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box longitude must be between -180 and +180'

   end

   def test_boundingBox_east_outOfBounds

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['eastLongitude'] = 200
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box longitude must be between -180 and +180'

   end

   def test_boundingBox_south_outOfBounds

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['southLatitude'] = 200
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box latitude must be between -90 and +90'

   end

   def test_boundingBox_north_outOfBounds

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['northLatitude'] = 200
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box latitude must be between -90 and +90'

   end

   def test_boundingBox_empty_unitsOfAltitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn['unitsOfAltitude'] = ''
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box altitude units of measure are missing'

   end

   def test_boundingBox_missing_unitsOfAltitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn.delete('unitsOfAltitude')
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson bounding box altitude units of measure are missing'

   end

   def test_empty_boundingBox_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: bounding box object is empty'

   end

end
