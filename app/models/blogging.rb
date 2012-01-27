class Blogging < Assignment

  def is_short?
    score == "1000"
  end

  def is_substantial?
    score == "5000"
  end

end
