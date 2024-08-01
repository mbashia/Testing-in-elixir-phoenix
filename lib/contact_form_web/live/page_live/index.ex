defmodule ContactFormWeb.PageLive.Index do
  use ContactFormWeb, :live_view
  alias ContactForm.ClientsRequests.Clients
  alias ContactForm.ClientsRequests.Client

  def mount(_params, _session, socket) do
    changeset = Clients.change_contact_form(%Client{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:client_request, %Client{})
     |> assign(:errors_list_length, 0)
     |> assign(:live_view_height, "h-[94vh] md:h-[80vh]")}
  end

  def handle_event("validate", %{"client" => client_request_params}, socket) do
    changeset =
      socket.assigns.client_request
      |> Clients.change_contact_form(client_request_params)
      |> Map.put(:action, :validate)

    IO.inspect(changeset)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"client" => client_request_params}, socket) do
    case Clients.create_contact_request_record(client_request_params) do
      {:ok, _record} ->
        {:noreply,
         socket
         |> put_flash(:info, "Request  created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:changeset, changeset)
         |> assign(:live_view_height, get_live_view_height(changeset))}
    end
  end

  def get_live_view_height(changeset) do
    case length(changeset.errors) do
      0 -> "h-[94vh] md:h-[80vh] transition ease-in-out duration-300"
      _ -> "h-[950px]  md:h-[92vh] transition ease-in-out duration-300"
    end
  end



end

# active:ring-2 active:ring-[#227c68] active:border-transparent
