class EnrollmentsController < ApplicationController

def create
  current_user.enrollments.create(course: current_course)
  
    
     # Amount in cents
    @amount = current_course.cost * 100).to.i

    customer = Stripe::Customer.create(
      :email => current_user.email
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Flixstream',
      :currency    => 'usd'
    )

    redirect_to course_path(current_course)
     rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path



end 

private

def current_course
  @current_course ||= Course.find(params[:course_id])
end

end
