require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user_attributes) { attributes_for(:user, :login_user) }
  let(:user) { create(:user, :login_user) }

  describe 'POST /users' do
    context 'when payload is present' do
      before do
        payload = { 'sub' => user_attributes[:uid],
                    'email' => user_attributes[:email] }
        allow_any_instance_of(UsersController).to receive(:payload).and_return(payload)
      end

      context 'and a user is not craeted yet' do
        context 'and the uid is not registered' do
          it 'creates a user record' do
            aggregate_failures do
              expect do
                post '/users.json'
              end.to change(User.all, :count).by(1)
              expect(response).to have_http_status(200)
              expect(JSON.parse(response.body)['uid']).to eq user_attributes[:uid]
            end
          end
        end
        context 'and the uid has been registered already' do
          it 'does not create user' do
            create(:user, :login_user, email: "#{SecureRandom.hex(3)}@email.com")
            aggregate_failures do
              expect do
                post '/users.json'
              end.to change(User.all, :count).by(0)
              expect(response).to have_http_status(422)
            end
          end
        end
      end

      context 'and a user has been craeted already' do
        it 'saves a user record' do
          u = user
          aggregate_failures do
            expect do
              post '/users.json'
            end.to change(User.all, :count).by(0)
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['uid']).to eq u.uid
          end
        end
      end
    end

    context 'when payload is blank' do
      it 'raises error' do
        expect do
          post '/users.json'
        end.to raise_error(ArgumentError)
      end
    end
  end
end
