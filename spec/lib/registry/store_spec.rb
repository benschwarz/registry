require 'spec_helper'

class Moo
  extend Registry
end

module Registry
  RSpec.describe Store do

    subject(:store) { described_class }
    before { store.store(:zhopa, 'Is translated as an Ass in Russian') }

    let(:item) { { name: 'Konstantin' } }
    its(:instance) { should_not be_nil }
    its(:mutex) { should_not be_nil }

    it 'should fetch the item stored' do
      expect(store.fetch(:zhopa)).to match /Russian/
    end

    context 'class methods forward to the instance' do
      subject(:store) { described_class.instance }
      before do
        store.delete(:key)
        store[:key] = item
      end

      it 'should retrieve it from the store' do
        expect(store.fetch(:key)).to eq(item)
      end
    end
  end
end
