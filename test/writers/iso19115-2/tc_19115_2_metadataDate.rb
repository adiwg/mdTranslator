# MdTranslator - minitest of
# writers / iso19115_2 / class_miMetadata

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152MetadataDate < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_metadataDate

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_metadataDate',
                                                '//gmd:dateStamp[1]',
                                                '//gmd:dateStamp', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_metadataDate_missing_create

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataDate] = []

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_metadataDate',
                                                '//gmd:dateStamp[1]',
                                                '//gmd:dateStamp', 0)

      today = Time.now.strftime("%Y-%m-%d")
      expect = "<gmd:dateStamp>\n <gco:Date>#{today.to_s}</gco:Date>\n </gmd:dateStamp>"
      assert_equal expect, hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
