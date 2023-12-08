# MdTranslator - minitest of
# writers / iso19115_3 / class_citation

# History:
#  Stan Smith 2019-04-18 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Citation < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation] = TDClass.citation_full

   @@mdHash = mdHash

   def test_citation_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:alternateTitle].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:date].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:responsibleParty].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:responsibleParty].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:presentationForm].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:identifier].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:identifier].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:otherCitationDetails].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:onlineResource].delete_at(1)
      hIn[:metadata][:resourceInfo][:citation][:graphic].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_citation',
                                                '//mri:citation[1]',
                                                '//mri:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_citation',
                                                '//mri:citation[2]',
                                                '//mri:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_elements

      # empty elements
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

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_citation',
                                                '//mri:citation[3]',
                                                '//mri:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
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

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_citation',
                                                '//mri:citation[3]',
                                                '//mri:citation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
