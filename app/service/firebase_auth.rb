require 'google/apis/identitytoolkit_v3'

module FirebaseAuth
  class Client
    def initialize
      service_account_key_json_path = Rails.root.join('config', 'tich-de99a-firebase-adminsdk-v5ajg-262446fb32.json')
      @service = Google::Apis::IdentitytoolkitV3::IdentityToolkitService.new
      @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open(service_account_key_json_path),
        scope: [
          'https://www.googleapis.com/auth/identitytoolkit'
        ].join(' ')
      )
    end

    def get_user(uid:)
      return unless uid

      get_account_info(local_id: [uid])&.users&.first
    end

    def update_user(uid:, params:)
      return unless uid

      update_params = { local_id: uid }.merge(params)
      request = Google::Apis::IdentitytoolkitV3::SetAccountInfoRequest.new(update_params)
      @service.set_account_info(request)
    end

    def get_account_info(params)
      request = Google::Apis::IdentitytoolkitV3::GetAccountInfoRequest.new(params)
      @service.get_account_info(request)
    end
  end
end
