require 'spec_helper'
module Registry
  RSpec.describe Store do
    subject(:store) { described_class }
    let(:item) { { name: 'Konstantin' } }
    context 'class methods forward to the instance' do
      before do
        store.clear
        expect(store.empty?).to be(true)
        store[:key] = item
      end

      it 'should retrieve it from the store' do
        expect(store.fetch(:key)).to eq(item)
      end
    end
  end
end
