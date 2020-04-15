require "spec_helper"
require "rack"

module Rack
  RSpec.describe Diet do
    class DummyApp
      def call(*)
        body = ::File.read(::File.join(__dir__, "../support/dummy.html"))
        Rack::Response.new(body, 200, {"Content-Type" => "text/html"}).to_a
      end
    end

    def on_diet
      Diet.new(DummyApp.new, allowed_hosts: [*Diet::ALLOWED_HOSTS, "billetto.test"] )
    end

    def dummy_env
      {}
    end

    def dummy_body
      _, _, body = on_diet.(dummy_env)
      body.enum_for(:each).to_a.join('')
    end

    specify { expect(dummy_body).not_to match /googleapis\.com/ }
    specify { expect(dummy_body).not_to match /cloudfront\.net/ }
    specify { expect(dummy_body).not_to match /segment\.com/ }
    specify { expect(dummy_body).not_to match /googletagmanager\.com/ }
    specify { expect(dummy_body).not_to match /mapbox\.com/ }
    specify { expect(dummy_body).to match /\* { animation-duration: 0s !important; }/ }
    specify { expect(dummy_body).to match /\/sign_in\.js/ }
    specify { expect(dummy_body).to match /billetto\.test/ }
  end
end
