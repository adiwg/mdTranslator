# MdTranslator - minitest of
# readers / fgdc / module_horizontalReference

# History:
#  Stan Smith 2018-10-06 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcHorizontalReference < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialResolutionGeographic.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::HorizontalReference

   def test_geographicResolution_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hHorizon
      assert_equal 1, hHorizon[:spatialResolutions].length

      hResolution = hHorizon[:spatialResolutions][0]
      assert_nil hResolution[:scaleFactor]
      assert_empty hResolution[:measure]
      refute_empty hResolution[:geographicResolution]
      assert_nil hResolution[:levelOfDetail]

      hGeoResolution = hResolution[:geographicResolution]
      assert_equal 0.00009, hGeoResolution[:latitudeResolution]
      assert_equal 0.00004, hGeoResolution[:longitudeResolution]
      assert_equal 'decimal degrees', hGeoResolution[:unitOfMeasure]

      # missing units
      xIn.search('geogunit').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geographic latitude/longitude units are missing'

      # missing longitude
      xIn.search('longres').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geographic longitude resolution is missing'

      # missing latitude
      xIn.search('latres').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 3, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geographic latitude resolution is missing'

   end

end
