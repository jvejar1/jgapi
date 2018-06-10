class SchoolsController < ApplicationController
  def get_all
    @schools=School.all
    render :json => {schools:@schools}
  end

  def students #by school_id
    school=School.find(params[:id])
    @students=school.students
    render :json =>{students:@students}
  end
end
