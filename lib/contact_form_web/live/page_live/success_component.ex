defmodule ContactFormWeb.PageLive.SuccessComponent do
  use ContactFormWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="absolute mb-[-10px] inset-x-0 bottom-full flex justify-center">
      <div class="bg-[#2c4144] w-[75%] flex flex-col gap-2 h-[100px] rounded-xl px-6 py-4">
        <div class="flex justify-start items-center gap-4">
          <span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="21"
              fill="none"
              viewBox="0 0 20 21"
            >
              <path
                fill="#fff"
                d="M14.28 7.72a.748.748 0 0 1 0 1.06l-5.25 5.25a.748.748 0 0 1-1.06 0l-2.25-2.25a.75.75 0 1 1 1.06-1.06l1.72 1.72 4.72-4.72a.75.75 0 0 1 1.06 0Zm5.47 2.78A9.75 9.75 0 1 1 10 .75a9.76 9.76 0 0 1 9.75 9.75Zm-1.5 0A8.25 8.25 0 1 0 10 18.75a8.26 8.26 0 0 0 8.25-8.25Z"
              />
            </svg>
          </span>

          <span class="karla-500 text-lg text-white">Message Sent!</span>
        </div>

        <div class="flex justify-start items-center gap-4">
          <span class="karla-400 text-base text-white">
            Thanks for completing the form,we'll be in touch soon!
          </span>
        </div>
      </div>
    </div>
    """
  end
end
