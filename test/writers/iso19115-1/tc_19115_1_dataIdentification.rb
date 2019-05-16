# MdTranslator - minitest of
# writers / iso19115_1 / class_dataIdentification

# History:
#  Stan Smith 2019-04-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151DataIdentification < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_dataIdentification_minimum

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dataIdentification',
                                                '//mdb:identificationInfo[1]',
                                                '//mdb:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataIdentification_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:shortAbstract] = 'short abstract'

      hIn[:metadata][:resourceInfo][:credit] = ['credit one']
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = ['grid']
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << TDClass.build_spatialResolution('factor')
      hIn[:metadata][:resourceInfo][:temporalResolution] = []
      hIn[:metadata][:resourceInfo][:temporalResolution] << TDClass.build_duration(year: 8, mon: 7)
      hIn[:metadata][:additionalDocumentation] = []
      hIn[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation
      hIn[:metadata][:resourceInfo][:graphicOverview] = []
      hIn[:metadata][:resourceInfo][:graphicOverview] << TDClass.build_graphic('graphic one')
      hIn[:metadata][:resourceInfo][:resourceFormat] = []
      hIn[:metadata][:resourceInfo][:resourceFormat] << TDClass.build_resourceFormat('resource format one')
      hIn[:metadata][:resourceInfo][:resourceUsage] = []
      hIn[:metadata][:resourceInfo][:resourceUsage] << TDClass.build_resourceUsage(usage: 'first usage')
      hIn[:metadata][:associatedResource] = []
      hIn[:metadata][:associatedResource] << TDClass.build_associatedResource('crossReference')
      hIn[:metadata][:resourceInfo][:otherResourceLocale] = []
      hIn[:metadata][:resourceInfo][:otherResourceLocale] << TDClass.build_locale('ger')
      hIn[:metadata][:resourceInfo][:environmentDescription] = 'environment description'
      hIn[:metadata][:resourceInfo][:supplementalInfo] = 'supplemental information'

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dataIdentification',
                                                '//mdb:identificationInfo[2]',
                                                '//mdb:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataIdentification_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:shortAbstract] = 'short abstract'

      hIn[:metadata][:resourceInfo][:credit] = ['credit one', 'credit two']
      hIn[:metadata][:resourceInfo][:pointOfContact] << TDClass.build_responsibleParty('metadataReview', ['CID003'])
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = %w(grid vector)
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hIn[:metadata][:resourceInfo][:spatialResolution] << TDClass.build_spatialResolution('factor')
      hIn[:metadata][:resourceInfo][:spatialResolution] << TDClass.build_spatialResolution('detail')
      hIn[:metadata][:resourceInfo][:temporalResolution] = []
      hIn[:metadata][:resourceInfo][:temporalResolution] << TDClass.build_duration(year: 8, mon: 7)
      hIn[:metadata][:resourceInfo][:temporalResolution] << TDClass.build_duration(hour: 8, mon: 7)
      hIn[:metadata][:additionalDocumentation] = []
      hIn[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation
      hIn[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation
      hIn[:metadata][:resourceInfo][:resourceMaintenance] << TDClass.build_maintenance
      hIn[:metadata][:resourceInfo][:graphicOverview] = []
      hIn[:metadata][:resourceInfo][:graphicOverview] << TDClass.build_graphic('graphic one')
      hIn[:metadata][:resourceInfo][:graphicOverview] << TDClass.build_graphic('graphic two')
      hIn[:metadata][:resourceInfo][:resourceFormat] = []
      hIn[:metadata][:resourceInfo][:resourceFormat] << TDClass.build_resourceFormat('resource format one')
      hIn[:metadata][:resourceInfo][:resourceFormat] << TDClass.build_resourceFormat('resource format two')
      hKeywords1 = TDClass.build_keywords('keywords one', 'theme')
      TDClass.add_keyword(hKeywords1,'keyword one')
      TDClass.add_keyword(hKeywords1,'keyword two', 'KWID001')
      hIn[:metadata][:resourceInfo][:keyword] << hKeywords1
      hKeywords2 = TDClass.build_keywords('keywords two', 'place')
      TDClass.add_keyword(hKeywords2,'keyword three')
      TDClass.add_keyword(hKeywords2,'keyword four', 'KWID002')
      hIn[:metadata][:resourceInfo][:keyword] << hKeywords2
      hIn[:metadata][:resourceInfo][:resourceUsage] = []
      hIn[:metadata][:resourceInfo][:resourceUsage] << TDClass.build_resourceUsage(usage: 'first usage')
      hIn[:metadata][:resourceInfo][:resourceUsage] << TDClass.build_resourceUsage(usage: 'second usage', timeID: 'TP002')
      hIn[:metadata][:resourceInfo][:constraint] << TDClass.build_securityConstraint()
      hIn[:metadata][:associatedResource] = []
      hIn[:metadata][:associatedResource] << TDClass.build_associatedResource('crossReference')
      hIn[:metadata][:associatedResource] << TDClass.build_associatedResource('stereoMate')
      hIn[:metadata][:resourceInfo][:otherResourceLocale] = []
      hIn[:metadata][:resourceInfo][:otherResourceLocale] << TDClass.build_locale('ger')
      hIn[:metadata][:resourceInfo][:otherResourceLocale] << TDClass.build_locale('lat')
      hIn[:metadata][:resourceInfo][:environmentDescription] = 'environment description'
      hIn[:metadata][:resourceInfo][:supplementalInfo] = 'supplemental information'

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dataIdentification',
                                                '//mdb:identificationInfo[3]',
                                                '//mdb:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataIdentification_nonCompliantTopicCategory

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:keyword] = []
      hIn[:metadata][:resourceInfo][:topicCategory] = %w(biota invalid)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_dataIdentification',
                                                '//mdb:identificationInfo[4]',
                                                '//mdb:identificationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],'WARNING: ISO-19115-1 writer: invalid topic category: CONTEXT is invalid'

   end

end
