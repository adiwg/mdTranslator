# MdTranslator - minitest of
# reader / sbJson / module_browseCategory

# History:
#   Stan Smith 2017-06-22 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_browseCategory'

class TestReaderSbJsonBrowseCategory < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::BrowseCategory
   @@hIn = TestReaderSbJsonParent.getJson('browseCategory.json')

   def test_complete_browseCategory

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      aResourceTypes = @@NameSpace.unpack(hIn, hResInfo[:resourceTypes], hResponse)

      assert_equal 5, aResourceTypes.length
      assert_equal 'dataset', aResourceTypes[0][:type]
      assert_equal 'publication', aResourceTypes[1][:type]
      assert_equal 'project', aResourceTypes[2][:type]
      assert_equal 'sample', aResourceTypes[3][:type]
      assert_equal 'dataset', aResourceTypes[4][:type]
      assert_equal 'Some other category', aResourceTypes[4][:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_categories

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['browseCategories'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      aResourceTypes = @@NameSpace.unpack(hIn, hResInfo[:resourceTypes], hResponse)

      assert_empty aResourceTypes
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_categories

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('browseCategories')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      aResourceTypes = @@NameSpace.unpack(hIn, hResInfo[:resourceTypes], hResponse)

      assert_empty aResourceTypes
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
