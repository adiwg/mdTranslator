# MdTranslator - minitest of
# writers / fgdc / class_spatialDomain

# History:
#   Stan Smith 2017-11-25 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcSpatialDomain < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('spatialDomain')

   # TODO add schema validation test after schema update

   def test_spatialDomain_complete

      aReturn = TestReaderFgdcParent.get_complete('spatialDomain', './metadata/idinfo/spdom')
      assert_equal aReturn[0], aReturn[1]

   end

end
