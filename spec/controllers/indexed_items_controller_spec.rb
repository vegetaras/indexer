describe IndexedItemsController, type: :controller do
  describe 'index' do
    it 'returns indexed items' do
      first_item = create :indexed_item, url: 'https://test.com', content: 'Some content'
      second_item = create :indexed_item, url: 'https://othertest.com', content: 'Some other content'

      get :index

      expect(response.body).to eq([first_item, second_item].to_json)
    end
  end

  describe 'create' do
    let(:url) { 'https://test.com' }
    let(:body) do
      <<~HTML
        <h1>h1 content</h1>
        <h2>h2 content</h2>
        <h3>h3 content</h3>
        <h4>h4 content</h4>
        <a href="https://item.com">a content</a>
        <a>other content</a>
      HTML
    end

    before do
      stub_request(:get, url).to_return(body: body)
    end

    it 'creates indexed item' do
      post :create, params: { url: url }

      expect(json[:content]).to eq(['h1 content', 'h2 content', 'h3 content', 'https://item.com'].join(', '))
    end

    context 'when indexed item already exists' do
      let(:body) { '' }

      it 'overwrites existing item' do
        create :indexed_item, url: url, content: 'some content'

        post :create, params: { url: url }

        expect(json[:content]).to eq('')
      end
    end
  end
end
