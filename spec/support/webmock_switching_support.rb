module WebmockSwitchingSupport
  RSpec.shared_context 'webmock_switching' do
    before do
      WebMock.enable!
    end

    after do
      WebMock.disable!
    end
  end
end

RSpec.configure do |config|
  config.include WebmockSwitchingSupport, type: :job
end
