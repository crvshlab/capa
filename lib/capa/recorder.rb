class Recorder
  def record
    raise NotImplementedError
  end

  def cancel
    raise NotImplementedError
  end

  def can_record?
    raise NotImplementedError
  end
end