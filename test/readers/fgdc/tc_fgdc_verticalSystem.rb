# MdTranslator - minitest of
# readers / fgdc / module_verticalDepth

# History:
#   Stan Smith 2017-10-19 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcVerticalSystem < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('verticalSystem.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::VerticalReference

   def test_verticalSystem

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/vertdef')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hVertical = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hVertical
      assert_equal 2, hVertical[:spatialReferenceSystems].length

      # altitude system
      hAltSystem = hVertical[:spatialReferenceSystems][0]
      assert_nil hAltSystem[:systemType]
      assert_empty hAltSystem[:systemIdentifier]
      refute_empty hAltSystem[:systemParameterSet]

      hAltParams = hAltSystem[:systemParameterSet]
      assert_empty hAltParams[:projection]
      assert_empty hAltParams[:ellipsoid]
      refute_empty hAltParams[:verticalDatum]

      hAltDatum = hAltParams[:verticalDatum]
      refute_empty hAltDatum[:datumIdentifier]
      assert_equal 'altitude datum name', hAltDatum[:datumIdentifier][:identifier]
      refute hAltDatum[:isDepthSystem]
      assert_equal 'attribute values', hAltDatum[:encodingMethod]
      assert_equal 0.9, hAltDatum[:verticalResolution]
      assert_equal 'kilometers', hAltDatum[:unitOfMeasure]

      # depth system
      hDepthSystem = hVertical[:spatialReferenceSystems][1]
      assert_nil hDepthSystem[:systemType]
      assert_empty hDepthSystem[:systemIdentifier]
      refute_empty hDepthSystem[:systemParameterSet]

      hDepthParams = hDepthSystem[:systemParameterSet]
      assert_empty hDepthParams[:projection]
      assert_empty hDepthParams[:ellipsoid]
      refute_empty hDepthParams[:verticalDatum]

      hDepthDatum = hDepthParams[:verticalDatum]
      refute_empty hDepthDatum[:datumIdentifier]
      assert_equal 'depth datum name', hDepthDatum[:datumIdentifier][:identifier]
      assert hDepthDatum[:isDepthSystem]
      assert_equal 'explicit depth coordinate', hDepthDatum[:encodingMethod]
      assert_equal 1.0, hDepthDatum[:verticalResolution]
      assert_equal 'fathom', hDepthDatum[:unitOfMeasure]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
