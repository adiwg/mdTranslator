# MdTranslator - minitest of
# readers / fgdc / module_entityAttribute

# History:
#   Stan Smith 2017-09-06 original script

require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcEntityAttribute < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_entityAttribute_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDictionary = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDictionary
      refute_empty hDictionary[:citation]
      assert_equal 'FGDC EntityAttribute Section 5', hDictionary[:citation][:title]
      assert_equal 3, hDictionary[:domains].length
      assert_equal 4, hDictionary[:entities].length

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: FGDC reader: entity type definition source is missing'

   end

end
