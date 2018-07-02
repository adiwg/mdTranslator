# MdTranslator - minitest of
# reader / mdJson / module_image

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-06-22 refactored setup after removal of globals
#  Stan Smith 2014-12-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_imageDescription'

class TestReaderMdJsonImageDescription < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ImageDescription

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.imageDescription

   @@mdHash = mdHash

   def test_imageDescription_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'imageDescription.json')
      assert_empty errors

   end

   def test_complete_imageDescription_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 60.0, metadata[:illuminationElevationAngle]
      assert_equal 40.0, metadata[:illuminationAzimuthAngle]
      assert_equal 'image condition code', metadata[:imagingCondition]
      refute_empty metadata[:imageQualityCode]
      assert_equal 90, metadata[:cloudCoverPercent]
      assert_equal 9, metadata[:compressionQuantity]
      refute metadata[:triangulationIndicator]
      refute metadata[:radiometricCalibrationAvailable]
      refute metadata[:cameraCalibrationAvailable]
      refute metadata[:filmDistortionAvailable]
      refute metadata[:lensDistortionAvailable]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_imageDescription_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['illuminationElevationAngle'] = ''
      hIn['illuminationAzimuthAngle'] = ''
      hIn['imagingCondition'] = ''
      hIn['imageQualityCode'] = {}
      hIn['cloudCoverPercent'] = ''
      hIn['compressionQuantity'] = ''
      hIn['triangulationIndicator'] = ''
      hIn['radiometricCalibrationAvailable'] = ''
      hIn['cameraCalibrationAvailable'] = ''
      hIn['filmDistortionAvailable'] = ''
      hIn['lensDistortionAvailable'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:illuminationElevationAngle]
      assert_nil metadata[:illuminationAzimuthAngle]
      assert_nil metadata[:imagingCondition]
      assert_empty metadata[:imageQualityCode]
      assert_nil metadata[:cloudCoverPercent]
      assert_nil metadata[:compressionQuantity]
      refute metadata[:triangulationIndicator]
      refute metadata[:radiometricCalibrationAvailable]
      refute metadata[:cameraCalibrationAvailable]
      refute metadata[:filmDistortionAvailable]
      refute metadata[:lensDistortionAvailable]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_imageDescription_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('illuminationElevationAngle')
      hIn.delete('illuminationAzimuthAngle')
      hIn.delete('imagingCondition')
      hIn.delete('imageQualityCode')
      hIn.delete('cloudCoverPercent')
      hIn.delete('compressionQuantity')
      hIn.delete('triangulationIndicator')
      hIn.delete('radiometricCalibrationAvailable')
      hIn.delete('cameraCalibrationAvailable')
      hIn.delete('filmDistortionAvailable')
      hIn.delete('lensDistortionAvailable')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:illuminationElevationAngle]
      assert_nil metadata[:illuminationAzimuthAngle]
      assert_nil metadata[:imagingCondition]
      assert_empty metadata[:imageQualityCode]
      assert_nil metadata[:cloudCoverPercent]
      assert_nil metadata[:compressionQuantity]
      refute metadata[:triangulationIndicator]
      refute metadata[:radiometricCalibrationAvailable]
      refute metadata[:cameraCalibrationAvailable]
      refute metadata[:filmDistortionAvailable]
      refute metadata[:lensDistortionAvailable]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_imageDescription_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: image description object is empty: CONTEXT is coverage description'

   end

end
