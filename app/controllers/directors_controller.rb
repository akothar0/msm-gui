class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
  
  def create
    d = Director.new
    d.bio = params.fetch("query_bio")
    d.dob = params.fetch("query_dob")
    d.image = params.fetch("query_image")
    d.name = params.fetch("query_name")
    d.save

    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Director.where({ :id => the_id })
    the_director = matching_records.at(0)
    the_director.destroy
    redirect_to("/directors")
  end

  def modify
    the_id = params.fetch("an_id")
    matching_records = Director.where({ :id => the_id })
    d = matching_records.at(0)
    d.bio = params.fetch("query_bio")
    d.dob = params.fetch("query_dob")
    d.image = params.fetch("query_image")
    d.name = params.fetch("query_name")
    d.save

    redirect_to("/directors/#{d.id}")
  end

end
