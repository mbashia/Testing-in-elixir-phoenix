defmodule ContactFormWeb.PageLive.SuccessComponent do
  use ContactFormWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>This is success component</div>
    """
  end
end
