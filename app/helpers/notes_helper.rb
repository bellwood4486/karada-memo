module NotesHelper
  SUMMARY_NOTES_SIZE = 3

  def year_filter_select_tag(body, year = nil, options = {})
    select_tag(:year,
               options_for_select(year_filter_options(body),
                                  selected: body_notes_path(body, year: year)),
               options)
  end

  def year_filter_options(body)
    options = [['全て', body_notes_path(body)]]
    options.concat(body.years_noted.map { |y| ["#{y}年", body_notes_path(body, year: y)] })
  end
end
