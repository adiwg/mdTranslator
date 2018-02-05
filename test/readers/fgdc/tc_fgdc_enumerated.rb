# MdTranslator - minitest of
# readers / fgdc / module_enumerated

# History:
#   Stan Smith 2017-09-06 original script

require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcEnumerated < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_enumerated_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDictionary = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDictionary
      assert_equal 3, hDictionary[:domains].length

      hDomain = hDictionary[:domains][0]
      refute_nil hDomain[:domainId]
      assert_equal 'attribute 1 label', hDomain[:domainName]
      assert_equal 'attribute 1 label', hDomain[:domainCode]
      assert_equal 'FGDC enumerated domain', hDomain[:domainDescription]
      assert_equal 2, hDomain[:domainItems].length

      hItem0 = hDomain[:domainItems][0]
      assert_equal 'attribute 1 enumerated domain value 1', hItem0[:itemName]
      assert_equal 'attribute 1 enumerated domain value 1', hItem0[:itemValue]
      assert_equal 'attribute 1 enumerated domain value 1 definition', hItem0[:itemDefinition]
      assert_equal 'attribute 1 enumerated domain value 1 definition source', hItem0[:itemReference][:title]

      hItem1 = hDomain[:domainItems][1]
      assert_equal 'attribute 1 enumerated domain value 2', hItem1[:itemName]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
