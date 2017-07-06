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

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_equal 5, metadata[:resourceTypes].length
      assert_equal 'dataset', metadata[:resourceTypes][0][:type]
      assert_equal 'publication', metadata[:resourceTypes][1][:type]
      assert_equal 'project', metadata[:resourceTypes][2][:type]
      assert_equal 'sample', metadata[:resourceTypes][3][:type]
      assert_equal 'dataset', metadata[:resourceTypes][4][:type]
      assert_equal 'Some other category', metadata[:resourceTypes][4][:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_categories

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['browseCategories'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:resourceTypes]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_categories

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('browseCategories')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      assert_empty metadata[:resourceTypes]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
