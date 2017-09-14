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
      hMetadata = @@intMetadataClass.newMetadata

      metadata = @@NameSpace.unpack(hIn, hMetadata, hResponse)

      assert_equal 2, metadata[:associatedResources].length
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

      hResource = metadata[:associatedResources][0]
      assert_equal 2, hResource[:resourceTypes].length
      assert_equal 'project', hResource[:resourceTypes][0][:type]
      assert_nil hResource[:resourceTypes][0][:name]
      assert_equal 'dataset', hResource[:resourceTypes][1][:type]
      refute_empty hResource[:resourceCitation]

      hCitation = hResource[:resourceCitation]
      assert 'Assessing the Vulnerability of Vegetation to Future Climate in the North Central U.S.', hCitation[:title]
      assert_equal 1, hCitation[:identifiers].length

      hIdentifier = hCitation[:identifiers][0]
      assert_equal '504a01afe4b02b6b9f7bd940', hIdentifier[:identifier]
      assert_equal 'gov.sciencebase.catalog', hIdentifier[:namespace]
      assert_equal 'relatedItemId', hIdentifier[:description]

   end

   def test_relatedItems_missing_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('id')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newMetadata

      metadata = @@NameSpace.unpack(hIn, hMetadata, hResponse)

      assert_empty metadata[:associatedResources]
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_relatedItems_404

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['relatedItems']['link']['url'] = 'https://www.sciencebase.gov/catalog/itemLinks?itemId=123456789'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newMetadata

      metadata = @@NameSpace.unpack(hIn, hMetadata, hResponse)

      assert_empty metadata[:associatedResources]
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
