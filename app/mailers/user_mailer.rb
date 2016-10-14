class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(order)
    @order = order
    @url = 'http://jungle.com'
    order_string = "Your order, Order#" + order[:id].to_s
    mail(to: order.email, subject: order_string )
  end
end
