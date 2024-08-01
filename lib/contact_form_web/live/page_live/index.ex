defmodule ContactFormWeb.PageLive.Index do
  use ContactFormWeb, :live_view
  alias ContactForm.ClientsRequests.Clients
  alias ContactForm.ClientsRequests.Client

  @input_field_class "w-[100%]   hover:cursor-pointer hover:border-[#227c68] transition ease-in-out duration-200  karla-400 h-[50px] md:h-[60px] border-[1px]  my-0 md:my-2  border-gray-300 rounded-xl px-4 py-0 md:py-2 focus:outline-none focus:ring-2 focus:ring-[#227c68]/70 focus:border-transparent"
  @input_field_class_message "hover:cursor-pointer hover:border-[#227c68] transition ease-in-out duration-200 w-[100%] h-[120px] border-[1px]  my-0 md:my-2  border-gray-300 rounded-xl px-4 py-0 md:py-2 focus:outline-none focus:ring-2 focus:ring-[#227c68]/70 focus:border-transparent"

  def mount(_params, _session, socket) do
    changeset = Clients.change_contact_form(%Client{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:client_request, %Client{})
     |> assign(:errors_list_length, 0)
     |> assign(:is_success, true)
     |> assign(
       :first_name_input_class,
       @input_field_class
     )
     |> assign(
       :last_name_input_class,
       @input_field_class
     )
     |> assign(
       :email_input_class,
       @input_field_class
     )
     |> assign(
       :query_type_input_class,
       @input_field_class
     )
     |> assign(
       :message_input_class,
       @input_field_class_message
     )
     |> assign(
       :contact_consent_input_class,
       @input_field_class
     )
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
        changeset = Clients.change_contact_form(%Client{})

        {:noreply,
         socket
         |> assign(:is_success, true)
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:changeset, changeset)
         |> assign(:first_name_input_class, has_first_name_error?(changeset))
         |> assign(:last_name_input_class, has_last_name_error?(changeset))
         |> assign(:email_input_class, has_email_error?(changeset))
         |> assign(:query_type_input_class, has_query_type_error?(changeset))
         |> assign(:message_input_class, has_message_error?(changeset))
         |> assign(:contact_consent_input_class, has_contact_consent_error?(changeset))
         |> assign(:live_view_height, get_live_view_height(changeset))}
    end
  end

  def get_live_view_height(changeset) do
    case length(changeset.errors) do
      0 -> "h-[94vh] md:h-[80vh] transition ease-in-out duration-300"
      _ -> "h-[950px]  md:h-[93vh] transition ease-in-out duration-300"
    end
  end

  def error_class(changeset, field, height \\ "h-[50px] md:h-[60px]") do
    if Enum.any?(changeset.errors, fn {error_field, _error} -> error_field == field end) do
      "w-[100%] hover:cursor-pointer hover:border-[#227c68] transition ease-in-out duration-200 karla-400 #{height} border-[1px] my-0 md:my-2 border-red-700 rounded-xl px-4 py-0 md:py-2 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent"
    else
      "w-[100%] hover:cursor-pointer hover:border-[#227c68] transition ease-in-out duration-200 karla-400 #{height} border-[1px] my-0 md:my-2 border-gray-300 rounded-xl px-4 py-0 md:py-2 focus:outline-none focus:ring-2 focus:ring-[#227c68]/70 focus:border-transparent"
    end
  end

  def has_email_error?(changeset), do: error_class(changeset, :email)
  def has_contact_consent_error?(changeset), do: error_class(changeset, :contact_consent)
  def has_query_type_error?(changeset), do: error_class(changeset, :query_type)
  def has_first_name_error?(changeset), do: error_class(changeset, :first_name)
  def has_last_name_error?(changeset), do: error_class(changeset, :last_name)
  def has_message_error?(changeset), do: error_class(changeset, :message, "h-[120px]")
end

# w-[100%]    karla-400 h-[50px] md:h-[60px] border-[1px]  my-0 md:my-2  border-gray-300 rounded-xl px-4 py-0 md:py-2 focus:outline-none focus:ring-2 focus:ring-red-900 focus:border-transparent
