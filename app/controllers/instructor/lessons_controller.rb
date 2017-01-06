class Instructor::LessonsController < ApplicationController
 before_action :authenticate_user!
 before_action :require_authorized_for_current_section
 def new
     @lesson = Lesson.new
 end

 def create
   @lesson = @section.lessons.create(lesson_params)
   redirect_to instructor_course_path(current_section.course)
 end

private

def require_authorized_for_current_section
  if @section.couse.user != current_user
       return render text: "Unauthorized", status: :unauthorized
    end 
  end  


# can be called in views

helper_method :current_section 
 def current_section
    @current_section ||= Section.find(params[:section_id])
  end

#   ||= same thing as 
#   if @current_section == nil
#   @current_section = Section.find(params[:section_id])
#   @current_section
# else
#   @current_section
# end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end

end