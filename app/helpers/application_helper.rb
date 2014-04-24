module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def money(amount)
    number_to_currency(amount / 100.0)
  end
end
