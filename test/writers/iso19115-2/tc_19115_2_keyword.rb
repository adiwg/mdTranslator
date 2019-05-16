# MdTranslator - minitest of
# writers / iso19115_2 / class_keyword

# History:
#  Stan Smith 2018-10-125refactor to support schema 2.6.0 changes to projection
#  Stan Smith 2018-04-24 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-05-16 added isoTopicCategory to keyword
#  Stan Smith 2017-01-04 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Keyword < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hKeywords1 = TDClass.build_keywords
   TDClass.add_keyword(hKeywords1,'keyword one')
   TDClass.add_keyword(hKeywords1,'keyword two', 'KWID001')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeywords1

   @@mdHash = mdHash

   def test_keyword_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_keyword',
                                                '//gmd:descriptiveKeywords[1]',
                                                '//gmd:descriptiveKeywords', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_keyword',
                                                '//gmd:descriptiveKeywords[2]',
                                                '//gmd:descriptiveKeywords', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_keyword',
                                                '//gmd:topicCategory[1]',
                                                '//gmd:topicCategory', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_keyword',
                                                '//gmd:topicCategory[2]',
                                                '//gmd:topicCategory', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
