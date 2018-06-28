# frozen_string_literal: true

require 'aws-sdk'

module CSI
  module AWS
    # This module provides a client for making API requests to AWS WAF Regional.
    module WAFRegional
      @@logger = CSI::Plugins::CSILogger.create

      # Supported Method Parameters::
      # CSI::AWS::WAFRegional.connect(
      #   region: 'required - region name to connect (eu-west-1, ap-southeast-1, ap-southeast-2, eu-central-1, ap-northeast-2, ap-northeast-1, us-east-1, sa-east-1, us-west-1, us-west-2)',
      #   access_key_id: 'required - Use AWS STS for best privacy (i.e. temporary access key id)',
      #   secret_access_key: 'required - Use AWS STS for best privacy (i.e. temporary secret access key',
      #   sts_session_token: 'optional - Temporary token returned by STS client for best privacy'
      # )

      public_class_method def self.connect(opts = {})
        region = opts[:region].to_s.scrub.chomp.strip
        access_key_id = opts[:access_key_id].to_s.scrub.chomp.strip
        secret_access_key = opts[:secret_access_key].to_s.scrub.chomp.strip
        sts_session_token = opts[:sts_session_token].to_s.scrub.chomp.strip

        @@logger.info('Connecting to AWS WAFRegional...')
        if sts_session_token == ''
          waf_regional_obj = Aws::WAFRegional::Client.new(
            region: region,
            access_key_id: access_key_id,
            secret_access_key: secret_access_key
          )
        else
          waf_regional_obj = Aws::WAFRegional::Client.new(
            region: region,
            access_key_id: access_key_id,
            secret_access_key: secret_access_key,
            session_token: sts_session_token
          )
        end
        @@logger.info("complete.\n")

        return waf_regional_obj
      rescue => e
        return e.message
      end

      # Supported Method Parameters::
      # CSI::AWS::WAFRegional.disconnect(
      #   waf_regional_obj: 'required - waf_regional_obj returned from #connect method'
      # )

      public_class_method def self.disconnect(opts = {})
        waf_regional_obj = opts[:waf_regional_obj]
        @@logger.info('Disconnecting...')
        waf_regional_obj = nil
        @@logger.info("complete.\n")

        waf_regional_obj
      rescue => e
        return e.message
      end

      # Author(s):: Jacob Hoopes <jake.hoopes@gmail.com>

      public_class_method def self.authors
        authors = "AUTHOR(S):
          Jacob Hoopes <jake.hoopes@gmail.com>
        "

        authors
      end

      # Display Usage for this Module

      public_class_method def self.help
        puts "USAGE:
          waf_regional_obj = #{self}.connect(
            region: 'required - region name to connect (eu-west-1, ap-southeast-1, ap-southeast-2, eu-central-1, ap-northeast-2, ap-northeast-1, us-east-1, sa-east-1, us-west-1, us-west-2)',
            access_key_id: 'required - Use AWS STS for best privacy (i.e. temporary access key id)',
            secret_access_key: 'required - Use AWS STS for best privacy (i.e. temporary secret access key',
            sts_session_token: 'optional - Temporary token returned by STS client for best privacy'
          )
          puts waf_regional_obj.public_methods

          #{self}.disconnect(
            waf_regional_obj: 'required - waf_regional_obj returned from #connect method'
          )

          #{self}.authors
        "
      end
    end
  end
end
