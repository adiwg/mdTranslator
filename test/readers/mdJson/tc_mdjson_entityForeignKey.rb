# MdTranslator - minitest of
# reader / mdJson / module_entityForeignKey

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-06 refactored for mdJson 2.0
#   Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityForeignKey'

class TestReaderMdJsonForeignKey < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityForeignKey
   aIn = TestReaderMdJsonParent.getJson('entityForeignKey.json')
   @@hIn = aIn['foreignKey'][0]

   def test_entityForeignKey_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'entity.json', :fragment => 'foreignKey')
      assert_empty errors

   end

   def test_complete_FK_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'localAttributeCodeName0', metadata[:fkLocalAttributes][0]
      assert_equal 'localAttributeCodeName1', metadata[:fkLocalAttributes][1]
      assert_equal 'referencedEntityCodeName', metadata[:fkReferencedEntity]
      assert_equal 'referencedAttributeCodeName0', metadata[:fkReferencedAttributes][0]
      assert_equal 'referencedAttributeCodeName1', metadata[:fkReferencedAttributes][1]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_FK_localAttributeCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['localAttributeCodeName'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key local attribute code name is missing'

   end

   def test_missing_FK_localAttributeCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('localAttributeCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key local attribute code name is missing'

   end

   def test_empty_FK_referencedEntityCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['referencedEntityCodeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key referenced entity name is missing'

   end

   def test_missing_FK_referencedEntityCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('referencedEntityCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key referenced entity name is missing'

   end

   def test_empty_FK_referencedAttributeCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['referencedAttributeCodeName'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key referenced attribute name is missing'

   end

   def test_missing_FK_referencedAttributeCodeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('referencedAttributeCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data entity foreign key referenced attribute name is missing'

   end

   def test_empty_entityForeignKey_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson data entity foreign key object is empty'

   end

end
