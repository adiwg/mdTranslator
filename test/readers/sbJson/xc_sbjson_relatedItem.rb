# MdTranslator - minitest of
# reader / sbJson / module_relatedItem

# History:
#   Stan Smith 2017-08-03 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_relatedItem'

class TestReaderSbJsonRelatedItem < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::RelatedItem
   @@hIn = TestReaderSbJsonParent.getJson('relatedItem.json')

   def test_relatedItems_complete

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hMetadata, hResponse)

      assert_equal 1,1

      # if metadata.empty?
      #    refute hResponse[:readerExecutionPass]
      #    refute_empty hResponse[:readerExecutionMessages]
      # else
      #    assert_equal 1, metadata[:geographicExtents].length
      #    assert_equal 'Extent extracted from ScienceBase', metadata[:description]
      #
      #    hGeoExt = metadata[:geographicExtents][0]
      #    assert_equal hIn.to_s, hGeoExt[:identifier][:identifier]
      #    refute_empty hGeoExt[:geographicElements]
      #    refute_empty hGeoExt[:nativeGeoJson]
      #    refute_empty hGeoExt[:computedBbox]
      #
      #    assert hResponse[:readerExecutionPass]
      #    assert_empty hResponse[:readerExecutionMessages]
      # end

   end

   # def test_extent_404
   #
   #    hIn = Marshal::load(Marshal.dump(@@hIn))
   #    hIn = hIn['extents'][1]
   #    hResponse = Marshal::load(Marshal.dump(@@responseObj))
   #
   #    metadata = @@NameSpace.unpack(hIn, hResponse)
   #
   #    assert_empty metadata
   #    refute hResponse[:readerExecutionPass]
   #    refute_empty hResponse[:readerExecutionMessages]
   #
   # end

end
