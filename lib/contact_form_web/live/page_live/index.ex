defmodule ContactFormWeb.PageLive.Index do
  use ContactFormWeb, :live_view
  alias ContactForm.ClientsRequests.Clients
  alias ContactForm.ClientsRequests.Client

  def mount(_params, _session, socket) do
    changeset = Clients.change_contact_form(%Client{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:client_request, %Client{})}
  end

  def handle_event("validate", %{"client" => client_request_params}, socket) do
    # IO.inspect(client_request_params)

    changeset =
      socket.assigns.client_request
      |> Clients.change_contact_form(client_request_params)
      |> Map.put(:action, :validate)
      IO.inspect changeset

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"client" => client_request_params}, socket) do
    case Clients.create_contact_request_record(client_request_params) do
      {:ok, _record} ->
        {:noreply,
         socket
         |> put_flash(:info, "Request  created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

# active:ring-2 active:ring-[#227c68] active:border-transparent
