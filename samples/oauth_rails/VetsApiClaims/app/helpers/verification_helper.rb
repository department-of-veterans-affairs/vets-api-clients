module VerificationHelper
  def badge_class(veteran_confirmed)
    if veteran_confirmed.nil?
      'badge-danger'
    elsif veteran_confirmed
      'badge-success'
    else
      'badge-warning'
    end
  end

  def confirmed_text(veteran_confirmed)
    if veteran_confirmed.nil?
      'Unreachable'
    elsif veteran_confirmed
      'Confirmed' 
    else
      'Unconfirmed'
    end
  end
end
