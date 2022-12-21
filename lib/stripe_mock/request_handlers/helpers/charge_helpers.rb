# NOTE: somehow we receive an array instead of the new expected format.
module StripeMock
  module RequestHandlers
    module Helpers

      def add_refund_to_charge(refund, charge)
        refunds = charge[:refunds]

        if refunds.is_a?(Array)
          refunds = { data: refunds }
        elsif refunds.is_a?(Hash)
          refunds[:data] = [] if !refunds[:data]
        else
          refunds = { data: [] }
        end

        refunds[:data] << refund
        refunds[:total_count] = refunds[:data].count

        charge[:amount_refunded] = refunds[:data].reduce(0) {|sum, r| sum + r[:amount].to_i }
        charge[:refunded] = true

        charge[:refunds] = refunds
      end

    end
  end
end