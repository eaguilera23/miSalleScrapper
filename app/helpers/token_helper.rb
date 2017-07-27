require 'jwt'

module TokenHelper
  module_function

  $service_account_email = "firebase-adminsdk-dol2h@misalle-3ae7d.iam.gserviceaccount.com"
  $private_key = OpenSSL::PKey::RSA.new(File.read(Dir.pwd + "/app/support/new_private.pem"))
  
  def create_custom_token(matricula)
  now_seconds = Time.now.to_i

    payload = { 
      iss: $service_account_email,
      sub: $service_account_email,
      aud: "https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit",
      iat: now_seconds,
      exp: now_seconds+(60*60),
      uid: matricula.to_s
    }

    JWT.encode payload, $private_key, "RS256"
  end

end
