# MdTranslator - minitest of
# reader / sbJson / module_spatial

# History:
#   Stan Smith 2017-06-25 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_spatial'

class TestReaderSbJsonSpatial < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Spatial
   @@hIn = TestReaderSbJsonParent.getJson('spatial.json')

   def test_complete_spatial

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_equal 1, metadata[:extents].length

      hExtent = metadata[:extents][0]
      assert_equal 1, hExtent[:geographicExtents].length

      hGeoExtent = hExtent[:geographicExtents][0]
      refute hGeoExtent[:boundingBox].empty?

      hBbox = hGeoExtent[:boundingBox]
      assert_equal 23.22, hBbox[:northLatitude]
      assert_equal 12.12, hBbox[:eastLongitude]
      assert_equal 23.21, hBbox[:westLongitude]
      assert_equal 43, hBbox[:southLatitude]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_spatial_boundingBox

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['spatial']['boundingBox'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:extents]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_spatial_boundingBox

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['spatial'].delete('boundingBox')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:extents]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_spatial

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['spatial'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:extents]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_spatial

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('spatial')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:extents]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
