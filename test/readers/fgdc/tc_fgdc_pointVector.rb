# MdTranslator - minitest of
# readers / fgdc / module_pointVector

# History:
#   Stan Smith 2017-09-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcPointVector < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('pointVector.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::SpatialOrganization

   def test_pointVector_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spdoinfo')

      hResInfo = @@NameSpace.unpack(xIn, hResourceInfo, @@hResponseObj)

      refute_empty hResInfo
      assert_equal 1, hResInfo[:spatialReferenceSystems].length
      assert_equal 1, hResInfo[:spatialRepresentationTypes].length
      assert_equal 'vector', hResInfo[:spatialRepresentationTypes][0]
      assert_equal 2, hResInfo[:spatialRepresentations].length

      hRefSystem = hResInfo[:spatialReferenceSystems][0]
      assert_nil hRefSystem[:systemType]
      refute_empty hRefSystem[:systemIdentifier]
      assert_equal 'indirect reference', hRefSystem[:systemIdentifier][:identifier]

      hSpatialRep = hResInfo[:spatialRepresentations][0]
      assert_empty hSpatialRep[:gridRepresentation]
      refute_empty hSpatialRep[:vectorRepresentation]
      assert_empty hSpatialRep[:georectifiedRepresentation]
      assert_empty hSpatialRep[:georeferenceableRepresentation]

      hVector = hResInfo[:spatialRepresentations][0][:vectorRepresentation]
      assert_nil hVector[:topologyLevel]
      assert_equal 2, hVector[:vectorObject].length
      assert_equal 'Circular arc, three point center', hVector[:vectorObject][0][:objectType]
      assert_equal 9, hVector[:vectorObject][0][:objectCount]

      hVector = hResInfo[:spatialRepresentations][1][:vectorRepresentation]
      assert_equal 2, hVector[:topologyLevel]
      assert_equal 2, hVector[:vectorObject].length
      assert_equal 'Node', hVector[:vectorObject][0][:objectType]
      assert_equal 999, hVector[:vectorObject][0][:objectCount]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
