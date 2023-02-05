module LogInSupport
  RSpec.shared_context 'login' do
    let(:current_user) { create(:user, :login_user) }
    before do
      allow_any_instance_of(Firebase::Auth::Authenticable).to receive(:authenticate_entity).and_return(current_user)
    end
  end
end

RSpec.configure do |config|
  config.include LogInSupport, type: :request
end
