module CoinbaseCommerceClient
  module Webhook
    def self.construct_event(payload, sig_header, secret)
      data = JSON.parse(payload, symbolize_names: true)
      if data.key?(:event)
        WebhookSignature.verify_header(payload, sig_header, secret)
        CoinbaseCommerceClient::APIResources::Event.create_from(data[:event])
      else
        raise CoinbaseCommerceClient::Errors::WebhookInvalidPayload.new("No event in payload", sig_header, http_body: payload)
      end
    end

    module WebhookSignature
      def self.verify_header(payload, sig_header, secret)
        unless [payload, sig_header, secret].all?
          raise CoinbaseCommerceClient::Errors::WebhookInvalidPayload.new("Missing, payload or signature", sig_header, http_body: payload)
        end

        expected_sig = compute_signature(payload, secret)
        unless secure_compare(expected_sig, sig_header)
          raise CoinbaseCommerceClient::Errors::SignatureVerificationError.new(
            "No signatures found matching the expected signature for payload",
            sig_header, http_body: payload
          )
        end
        true
      end

      def self.secure_compare(a, b)
        return false unless a.bytesize == b.bytesize

        one = a.unpack "C#{a.bytesize}"
        res = 0
        b.each_byte {|byte| res |= byte ^ one.shift}
        res.zero?
      end

      private_class_method :secure_compare

      def self.compute_signature(payload, secret)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, payload)
      end

      private_class_method :compute_signature

    end
  end
end