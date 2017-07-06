# MdTranslator - minitest of
# reader / sbJson / module_date

# History:
#   Stan Smith 2017-06-14 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_date'

class TestReaderSbJsonDate < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Date
   @@hIn = TestReaderSbJsonParent.getJson('date.json')

   def test_complete_date

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 2, metadata[:dates].length

      # date [0]
      hDate = metadata[:dates][0]
      assert_equal 'publication', hDate[:dateType]
      assert hDate[:date].kind_of?(DateTime)
      assert_equal 'YMD', hDate[:dateResolution]
      assert_equal 'Publication Date', hDate[:description]

      # date [1]
      hDate = metadata[:dates][1]
      assert_equal 'Repository Created', hDate[:dateType]
      assert hDate[:date].kind_of?(DateTime)
      assert_equal 'Y', hDate[:dateResolution]
      assert_equal 'Repository Created', hDate[:description]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_date

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dates'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:dates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_date

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dates')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:dates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
