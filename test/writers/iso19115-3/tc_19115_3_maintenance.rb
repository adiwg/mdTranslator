# MdTranslator - minitest of
# writers / iso19115_3 / class_maintenance

# History:
#  Stan Smith 2019-05-08 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Maintenance < TestWriter191151Parent

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

   def test_maintenance_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:date].delete_at(1)
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:scope].delete_at(1)
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:note].delete_at(1)
      hIn[:metadata][:metadataInfo][:metadataMaintenance][:contact].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_maintenance',
                                                '//mdb:metadataMaintenance[1]',
                                                '//mdb:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_maintenance_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_maintenance',
                                                '//mdb:metadataMaintenance[2]',
                                                '//mdb:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_maintenance_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMaintenance = hIn[:metadata][:metadataInfo][:metadataMaintenance]

      # empty elements
      hMaintenance[:date] = []
      hMaintenance[:scope] = []
      hMaintenance[:note] = []
      hMaintenance[:contact] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_maintenance',
                                                '//mdb:metadataMaintenance[3]',
                                                '//mdb:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hMaintenance.delete(:date)
      hMaintenance.delete(:scope)
      hMaintenance.delete(:note)
      hMaintenance.delete(:contact)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_maintenance',
                                                '//mdb:metadataMaintenance[3]',
                                                '//mdb:metadataMaintenance', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
