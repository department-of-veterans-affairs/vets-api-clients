module VerificationHelper
  def badge_class(veteran_confirmed)
    if veteran_confirmed.is_a? VeteranVerification::BadResponse
      'badge-danger'
    elsif veteran_confirmed
      'badge-success'
    else
      'badge-warning'
    end
  end

  def confirmed_text(veteran_confirmed)
    if veteran_confirmed.is_a? VeteranVerification::BadResponse
      'Unreachable'
    elsif veteran_confirmed
      'Confirmed' 
    else
      'Unconfirmed'
    end
  end
end
