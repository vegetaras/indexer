describe IndexedItem, type: :model do
  context 'when url is empty' do
    it 'is invalid' do
      item = build :indexed_item, url: ''

      expect(item).to be_invalid
    end
  end

  context 'when url is not empty' do
    it 'is valid' do
      item = build :indexed_item, url: 'https://test.com'

      expect(item).to be_valid
    end
  end

  context 'when url is not unique' do
    it 'is invalid' do
      create :indexed_item, url: 'https://test.com'
      item = build :indexed_item, url: 'https://test.com'

      expect(item).to be_invalid
    end
  end

  context 'when url is unique' do
    it 'is valid' do
      create :indexed_item, url: 'https://test.com'
      item = build :indexed_item, url: 'https://othertest.com'

      expect(item).to be_valid
    end
  end
end
