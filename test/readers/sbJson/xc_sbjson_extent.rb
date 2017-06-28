# MdTranslator - minitest of
# reader / sbJson / module_extent

# History:
#   Stan Smith 2017-06-28 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_extent'

class TestReaderSbJsonExtent < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Extent
   @@hIn = TestReaderSbJsonParent.getJson('extent.json')

   def test_extent_complete

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn = hIn['extents'][0]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      if metadata.empty?
         refute hResponse[:readerExecutionPass]
         refute_empty hResponse[:readerExecutionMessages]
      else
         assert_equal 1, metadata[:geographicExtents].length
         assert_equal 'Extent extracted from ScienceBase', metadata[:description]

         hGeoExt = metadata[:geographicExtents][0]
         assert_equal hIn['extents'][0], hGeoExt[:identifier][:identifier]
         refute_empty hGeoExt[:geographicElements]
         refute_empty hGeoExt[:nativeGeoJson]
         refute_empty hGeoExt[:computedBbox]

         assert hResponse[:readerExecutionPass]
         assert_empty hResponse[:readerExecutionMessages]
      end

   end

   def test_extent_404

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn = hIn['extents'][1]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
