require 'spec_helper'
require 'comfy_conf'

describe ComfyConf do
  let(:file) { fixture('valid_config.yml') }
  let(:subject) do
    ComfyConf::Parser.new(file) do
      prop :name, required: true, type: String
      prop :age, required: false, type: Numeric
      prop :favorite_pizza, type: String, default: 'cheeze'

      config :opts, required: true do
        prop :woah, required: true, type: String

        config :nested_opts, required: false do
          prop :so_nested, required: true, type: String
        end
      end
    end
  end

  let(:data) { subject.data }

  shared_examples 'missing required opt' do
    it 'freaks the hell out' do
      expect{subject.data}.to raise_error(ComfyConf::MissingOption)
    end
  end

  it 'loads a configuration' do
    expect(data.name).to eql("Henry")
    expect(data.opts.woah).to eql("Hi!")
    expect(data.opts.nested_opts.so_nested).to eql("Like a russian doll.")
  end

  it 'provides default values when configured' do
    expect(data.favorite_pizza).to eql('cheeze')
  end

  context 'When a defaulted value is overriden' do
    let(:file) { fixture('overriden_default.yml') }

    it 'provides the configured value instead of the default' do
      expect(data.favorite_pizza).to eql('gate')
    end
  end

  context 'When missing a required prop' do
    let(:file) { fixture('missing_prop_config.yml') }
    it_behaves_like 'missing required opt'
  end

  context 'when missing a required section' do
    let(:file) { fixture('missing_section_config.yml') }

    it 'has no chill' do
      expect{subject.data}.to raise_error(ComfyConf::MissingSection)
    end
  end

  context 'when a nested required opt is missing' do
    let(:file) { fixture('missing_nested_required.yml') }
    it_behaves_like 'missing required opt'

    it 'includes the full path of the opt in the error message' do
      expect{subject.data}.
        to raise_error(
          ComfyConf::MissingOption,
          /root\[opts\]\[nested_opts\]\[so_nested\]/)
    end
  end
end
