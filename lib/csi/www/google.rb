# frozen_string_literal: true

module CSI
  module WWW
    # This plugin supports Google actions.
    module Google
      # Supported Method Parameters::
      # browser_obj = CSI::WWW::Google.open(
      #   browser_type: :firefox|:chrome|:ie|:headless,
      #   proxy: 'optional - scheme://proxy_host:port',
      #   with_tor: 'optional - boolean (defaults to false)'
      # )

      public

      def self.open(opts = {})
        browser_type = if opts[:browser_type].nil?
                         :firefox
                       else
                         opts[:browser_type]
                       end

        proxy = opts[:proxy].to_s unless opts[:proxy].nil?

        with_tor = if opts[:with_tor]
                     true
                   else
                     false
                   end

        if proxy
          if with_tor
            browser_obj = CSI::Plugins::TransparentBrowser.open(
              browser_type: browser_type,
              proxy: proxy,
              with_tor: with_tor
            )
          else
            browser_obj = CSI::Plugins::TransparentBrowser.open(
              browser_type: browser_type,
              proxy: proxy
            )
          end
        else
          browser_obj = CSI::Plugins::TransparentBrowser.open(
            browser_type: browser_type
          )
        end

        browser_obj.goto('https://www.google.com')

        return browser_obj
      rescue => e
        raise e
      end

      # Supported Method Parameters::
      # browser_obj = CSI::WWW::Google.search(
      #   browser_obj: 'required - browser_obj returned from #open method',
      #   q: 'required - search string'
      # )

      public

      def self.search(opts = {})
        browser_obj = opts[:browser_obj]
        q = opts[:q].to_s

        browser_obj.text_field(name: 'q').wait_until_present.set(q)
        browser_obj.button(name: 'btnG').wait_until_present.click

        return browser_obj
      rescue => e
        raise e
      end

      # Supported Method Parameters::
      # browser_obj = CSI::WWW::Google.search_linkedin_for_employees_by_company(
      #   browser_obj: 'required - browser_obj returned from #open method',
      #   company: 'required - company string'
      # )

      public

      def self.search_linkedin_for_employees_by_company(opts = {})
        browser_obj = opts[:browser_obj]
        company = opts[:company].to_s.scrub
        q = "site:linkedin.com inurl:in intext:\"#{company}\""

        browser_obj.text_field(name: 'q').wait_until_present.set(q)
        browser_obj.button(name: 'btnG').wait_until_present.click
        sleep 3 # Cough: <hack>

        return browser_obj
      rescue => e
        raise e
      end

      # Supported Method Parameters::
      # browser_obj = CSI::WWW::Google.close(
      #   browser_obj: 'required - browser_obj returned from #open method',
      # )

      public

      def self.close(opts = {})
        browser_obj = opts[:browser_obj]
        browser_obj = CSI::Plugins::TransparentBrowser.close(browser_obj: browser_obj)
      rescue => e
        raise e
      end

      # Author(s):: Jacob Hoopes <jake.hoopes@gmail.com>

      public

      def self.authors
        authors = "AUTHOR(S):
          Jacob Hoopes <jake.hoopes@gmail.com>
        "

        authors
      end

      # Display Usage for this Module

      public

      def self.help
        puts %{USAGE:
          browser_obj = #{self}.open(
            browser_type: 'optional :firefox|:chrome|:ie|:headless (Defaults to :firefox)',
            proxy: 'optional - scheme://proxy_host:port',
            with_tor: 'optional - boolean (defaults to false)'
          )
          puts "browser_obj.public_methods"

          browser_obj = #{self}.search(
            browser_obj: 'required - browser_obj returned from #open method',
            q: 'required - search string'
          )

          browser_obj = #{self}.search_linkedin_for_employees_by_company(
            browser_obj: 'required - browser_obj returned from #open method',
            company: 'required - company string'
          )

          browser_obj = #{self}.close(
            browser_obj: 'required - browser_obj returned from #open method'
          )

          #{self}.authors
        }
      end
    end
  end
end
