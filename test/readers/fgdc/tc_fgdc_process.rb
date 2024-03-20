# MdTranslator - minitest of
# readers / fgdc / module_process

# History:
#   Stan Smith 2017-08-31 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcProcess < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('lineage.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Lineage

   def test_process_complete

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xDoc)
      xIn = @@xDoc.xpath('./metadata/dataqual/lineage')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hLineage = @@NameSpace.unpack(xIn, hResponse)

      refute_nil hLineage

      aSteps = hLineage[:processSteps]
      assert_equal 4, aSteps.length

      # first process step that is not a methodology
      hProcess = aSteps[2]
      refute_empty hProcess
      assert_nil hProcess[:stepId]
      assert_equal 'my proc step 1 description', hProcess[:description]
      assert_nil hProcess[:rationale]
      refute_empty hProcess[:timePeriod]
      assert_equal 1, hProcess[:processors].length
      assert_empty hProcess[:stepSources]
      assert_empty hProcess[:stepProducts]
      assert_empty hProcess[:scope]

      hTimePeriod = hProcess[:timePeriod]
      assert_equal 'Step completion dateTime', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      refute_empty hTimePeriod[:endDateTime]

      hProcessor = hProcess[:processors][0]
      assert_equal 'processor', hProcessor[:roleName]
      assert_empty hProcessor[:roleExtents]
      assert_equal 1, hProcessor[:parties].length

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: contact address is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: contact voice phone is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: lineage procedure date is missing'

   end

end
