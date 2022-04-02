class BriefNameGenerator
  def generate_brief_name(first_name, last_name, sport)
    case sport
    when "baseball"
      "#{first_name[0]}. #{last_name[0]}."
    when "basketball"
      "#{first_name} #{last_name[0]}."
    when "football"
      "#{first_name[0]}. #{last_name}"
    else
      nil
    end
  end
end
