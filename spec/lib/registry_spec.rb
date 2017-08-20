require 'spec_helper'

require 'support/parser'

module Support
  RSpec.describe Parser do
    subject(:parser_class) { described_class }
    let(:test_hash) { { 'name' => 'Konstantin' } }

    describe described_class do
      it { is_expected.to respond_to(:for) }
      its(:store) { should eq(Registry::Store.instance) }
      context '#store' do
        subject(:store) { described_class.store }
        its(:keys) { should include(:yaml, :yml, :json, :javascript) }
      end

    end

    shared_examples_for :part_of_registry do |klass, *identifiers, serialized|
      describe klass do
        it 'should automatically register the class name' do
          identifiers.each do |id|
            expect(klass.for(id) { true }).to be(true)
          end
        end

        it 'should be registered to handle a child' do
          klass.identifiers.each do |id|
            expect(Parser.for(id) \
            { parse(serialized) }).to eq(test_hash)
          end
        end

        it 'should raise NotRegistered for unregistered classes' do
          expect { klass.for(:xyz) { echo } }.to raise_error(Registry::NotRegistered)
        end
      end
    end

    context Json do
      it_should_behave_like :part_of_registry,
                            Json,
                            :json, :javascript,
                            %Q[{"name":"Konstantin"}]
    end

    context Yaml do
      it_should_behave_like :part_of_registry,
                            Yaml,
                            :yml, :yaml,
                            %Q[---\r\nname: Konstantin\r\n]
    end
  end
end
