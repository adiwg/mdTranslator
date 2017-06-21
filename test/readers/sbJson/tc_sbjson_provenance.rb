# MdTranslator - minitest of
# reader / sbJson / module_provenance

# History:
#   Stan Smith 2017-06-20 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_provenance'

class TestReaderSbJsonProvenance < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Provenance
   @@hIn = TestReaderSbJsonParent.getJson('provenance.json')

   def test_complete_provenance

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 2, metadata[:dates].length
      assert metadata[:dates][0][:date].kind_of?(Date)
      assert metadata[:dates][1][:date].kind_of?(DateTime)
      assert_equal 'YMD', metadata[:dates][0][:dateResolution]
      assert_equal 'YMDhmsZ', metadata[:dates][1][:dateResolution]
      assert_equal 'creation', metadata[:dates][0][:dateType]
      assert_equal 'lastUpdate', metadata[:dates][1][:dateType]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_provenance

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['provenance'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:dates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_provenance

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('provenance')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:dates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
