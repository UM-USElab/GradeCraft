class BloggingGrade < Grade

  def score
    if substantial?
    score = 5000
    else
    score = 1000
    end
  end

end