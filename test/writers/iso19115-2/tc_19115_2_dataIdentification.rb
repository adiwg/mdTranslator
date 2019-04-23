# MdTranslator - minitest of
# writers / iso19115_2 / class_dataIdentification

# History:
#  Stan Smith 2018-04-18 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-20 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152DataIdentification < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_dataIdentification_minimum

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dataIdentification',
                                                '//gmd:identificationInfo[1]',
                                                '//gmd:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataIdentification_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:keyword] = []
      hIn[:metadata][:resourceInfo][:topicCategory] = %w(biota health)
      hIn[:metadata][:resourceInfo][:shortAbstract] = 'short abstract'
      hIn[:metadata][:resourceInfo][:credit] = ['credit one', 'credit two']
      hIn[:metadata][:resourceInfo][:environmentDescription] = 'environment description'
      hIn[:metadata][:resourceInfo][:supplementalInfo] = 'supplemental information'
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = %w(grid vector)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dataIdentification',
                                                '//gmd:identificationInfo[2]',
                                                '//gmd:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataIdentification_nonCompliantTopicCategory

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:keyword] = []
      hIn[:metadata][:resourceInfo][:topicCategory] = %w(biota invalid)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dataIdentification',
                                                '//gmd:identificationInfo[3]',
                                                '//gmd:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: invalid topic category: CONTEXT is invalid'

   end

end
