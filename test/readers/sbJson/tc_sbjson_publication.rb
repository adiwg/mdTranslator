# MdTranslator - minitest of
# reader / sbJson / module_publication

# History:
#   Stan Smith 2017-06-25 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_publication'

class TestReaderSbJsonPublication < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Publication
   @@hIn = TestReaderSbJsonParent.getJson('publication.json')

   def test_complete_publication

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo =  @@intMetadataClass.newResourceInfo
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hCitation, hResponse)

      assert_equal 1, hResourceInfo[:resourceTypes].length
      assert_equal 'journal', hResourceInfo[:resourceTypes][0][:type]
      assert_equal 'journal', hResourceInfo[:resourceTypes][0][:name]

      assert_equal 1, hCitation[:otherDetails].length
      assert_equal 'Citation note', hCitation[:otherDetails][0]

      refute_empty hCitation[:series]
      assert_equal 'The Journal Name', hCitation[:series][:seriesName]
      assert_equal 'February 2016', hCitation[:series][:seriesIssue]

      refute_empty hResourceInfo[:defaultResourceLocale]
      assert_equal 'ESP', hResourceInfo[:defaultResourceLocale][:languageCode]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
