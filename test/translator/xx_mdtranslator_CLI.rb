# MdTranslator - minitest of
# adiwg / mdtranslator / bin

# History:
#   Stan Smith 2017-04-21 original script

require 'minitest/autorun'
require_relative '../../lib/adiwg/mdtranslator_cli'

# test CLI parameters
# no writer is specified; the input mdJson will only be scanned for errors
class TestMdtranslatorCLI < MiniTest::Test

    def test_mdtranslatorCLI_default

        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')

        out, err = capture_io do
            Mdtranslator.start [ 'translate', file, '-r', 'mdJson' ]
        end

        assert_equal 'Success', out
        assert_equal err, ''

    end

    def test_mdtranslatorCLI_err

        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_invalid.json')

        out, err = capture_io do
            Mdtranslator.start [ 'translate', file, '-r', 'mdJson' ]
        end

        out = out.slice(0, 6)
        assert_equal 'Failed', out
        assert_equal err, ''

    end

    def test_mdtranslatorCLI_messages_text

        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_invalid.json')

        out, err = capture_io do
            Mdtranslator.start [ 'translate', file, '-r', 'mdJson', '-m', 'text' ]
        end

        out = out.slice(0,6)
        assert_equal 'Failed', out
        assert_equal err, ''

    end

    def test_mdtranslatorCLI_messages_json

        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_invalid.json')

        out, err = capture_io do
            Mdtranslator.start [ 'translate', file, '-r', 'mdJson', '-m', 'json' ]
        end

        out = out.slice(0,1)
        assert_equal '{', out
        assert_equal err, ''

    end

    def test_mdtranslatorCLI_object_true

        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')

        out, err = capture_io do
            Mdtranslator.start [ 'translate', file, '-r', 'mdJson', '-o', true ]
        end

        assert_equal 'Success', out
        assert_equal err, ''

    end

end

