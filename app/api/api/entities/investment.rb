module API
  module Entities
    class Investment < Grape::Entity
      expose :id
      expose :investor_mail, as: :investor_email
      expose :amount
    end
  end
end
