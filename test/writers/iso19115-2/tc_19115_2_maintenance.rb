# MdTranslator - minitest of
# writers / iso19115_2 / class_maintenance

# History:
#  Stan Smith 2018-04-25 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-05 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Maintenance < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hMaintenance = TDClass.build_maintenance

   hMaintenance[:date] << TDClass.build_date('2018-05-25','lastUpdate')
   hMaintenance[:date] << TDClass.build_date('2019-04','nextUpdate')

   hMaintenance[:scope] << TDClass.scope
   hMaintenance[:scope] << TDClass.scope

   hMaintenance[:contact] << TDClass.build_responsibleParty('custodian',['CID003'])
   hMaintenance[:contact] << TDClass.build_responsibleParty('rightHolder',['CID004'])

   mdHash[:metadata][:metadataInfo][:metadataMaintenance] = hMaintenance

   @@mdHash = mdHash

   def test_maintenance_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_maintenance',
                                                '//gmd:metadataMaintenance[1]',
                                                '//gmd:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_maintenance_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:date].delete_at(1)
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:scope].delete_at(1)
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:contact].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_maintenance',
                                                '//gmd:metadataMaintenance[2]',
                                                '//gmd:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_maintenance_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:date] = []
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:scope] = []
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:note] = []
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:contact] = []

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_maintenance',
                                                '//gmd:metadataMaintenance[3]',
                                                '//gmd:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
