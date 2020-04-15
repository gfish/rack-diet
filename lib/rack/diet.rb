require "rack/diet/version"
require "nokogiri"
require "uri"

module Rack
  class Diet
    ALLOWED_HOSTS = %w(localhost 127.0.0.1)

    def initialize(app, allowed_hosts: ALLOWED_HOSTS)
      @app = app
      @allowed_hosts = allowed_hosts + [nil]
    end

    def call(env)
      status, headers, body = @app.call(env)

      if headers.fetch("Content-Type", "").match /text\/html/
        page = ::Nokogiri::HTML(body.enum_for(:each).to_a.join)
        page.css('script[src]')
          .select { |node| !@allowed_hosts.include?(URI(node["src"]).host) }
          .each   { |node| node.remove }
        page.css('script:not([src])')
          .select { |node| node.text.match /\.src\s*=/ }
          .each   { |node| node.remove }
        page.css('noscript')
          .each { |node| node.remove }
        page.css('link[rel="stylesheet"]')
          .select { |node| !@allowed_hosts.include?(URI(node["href"]).host) }
          .each   { |node| node.remove }
        page.css('head')
          .each { |node| node.add_child <<~EOS
            <style>
              * { animation-duration: 0s !important; }
            </style>
          EOS
          }

        Rack::Response.new(page.to_s, status, headers).to_a
      else
        Rack::Response.new(body, status, headers).to_a
      end
    end
  end
end
