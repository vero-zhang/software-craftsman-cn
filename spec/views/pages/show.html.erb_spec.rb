require 'rails_helper'

describe 'pages/show.html.erb', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:page) { FactoryGirl.create(:page) }
  before { allow(controller).to receive(:current_user) { user } }

  it 'escapes title in social share button' do
    page.title = 'f\'></div><button id="danger" onclick="javascript:alert(\'ooh\')">\
share</button><div style="display:none"'
    assign(:page, page)

    render

    doc = Nokogiri::HTML.fragment(rendered)
    expect(doc.at('button#danger')).to be_nil
  end
end
