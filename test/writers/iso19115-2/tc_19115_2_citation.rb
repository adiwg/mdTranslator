# MdTranslator - minitest of
# writers / iso19115_2 / class_citation

# History:
#  Stan Smith 2018-04-17 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-19 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Citation < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation] = TDClass.citation_full

   @@mdHash = mdHash

   def test_citation_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_citation',
                                                '//gmd:citation[1]',
                                                '//gmd:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_empty_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hCitation = hIn[:metadata][:resourceInfo][:citation]
      hCitation[:alternateTitle] = []
      hCitation[:date] = []
      hCitation[:onlineResource] = []
      hCitation[:edition] = ''
      hCitation[:responsibleParty] = []
      hCitation[:presentationForm] = []
      hCitation[:identifier] = []
      hCitation[:series] = {}
      hCitation[:otherCitationDetails] = []
      hCitation[:onlineResource] = []
      hCitation[:graphic] = []

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_citation',
                                                '//gmd:citation[2]',
                                                '//gmd:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is main resource citation'

   end

   def test_citation_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hCitation = hIn[:metadata][:resourceInfo][:citation]
      hCitation.delete(:alternateTitle)
      hCitation.delete(:date)
      hCitation.delete(:onlineResource)
      hCitation.delete(:edition)
      hCitation.delete(:responsibleParty)
      hCitation.delete(:presentationForm)
      hCitation.delete(:identifier)
      hCitation.delete(:series)
      hCitation.delete(:otherCitationDetails)
      hCitation.delete(:onlineResource)
      hCitation.delete(:graphic)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_citation',
                                                '//gmd:citation[2]',
                                                '//gmd:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is main resource citation'

   end

end
